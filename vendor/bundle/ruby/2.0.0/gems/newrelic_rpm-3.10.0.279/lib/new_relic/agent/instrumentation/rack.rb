# encoding: utf-8
# This file is distributed under New Relic's license terms.
# See https://github.com/newrelic/rpm/blob/master/LICENSE for complete details.

require 'new_relic/agent/instrumentation/controller_instrumentation'

module NewRelic
  module Agent
    module Instrumentation
      # == Instrumentation for Rack
      #
      # Since version 3.9.0, New Relic instruments Rack middlewares by default.
      # As a result, this entire module has been deprecated.
      #
      # @api public
      # @deprecated
      #
      module Rack
        include ControllerInstrumentation

        def newrelic_request_headers(_)
          @newrelic_request.env
        end

        def call_with_newrelic(*args)
          @newrelic_request = ::Rack::Request.new(args.first)
          perform_action_with_newrelic_trace(:category => :middleware, :request => @newrelic_request) do
            result = call_without_newrelic(*args)
            # Ignore cascaded calls
            Transaction.abort_transaction! if result.first == 404
            result
          end
        end

        def self.included middleware #:nodoc:
          middleware.class_eval do
            alias call_without_newrelic call
            alias call call_with_newrelic
          end
        end

        def self.extended middleware #:nodoc:
          middleware.class_eval do
            class << self
              alias call_without_newrelic call
              alias call call_with_newrelic
            end
          end
        end

        def _nr_has_middleware_tracing
          true
        end
      end

      module RackHelpers
        def self.rack_version_supported?
          version = ::NewRelic::VersionNumber.new(::Rack.release)
          min_version = ::NewRelic::VersionNumber.new('1.1.0')
          version >= min_version
        end

        def self.middleware_instrumentation_enabled?
          rack_version_supported? && !::NewRelic::Agent.config[:disable_middleware_instrumentation]
        end

        def self.check_for_late_instrumentation(app)
          return if @checked_for_late_instrumentation
          @checked_for_late_instrumentation = true
          if middleware_instrumentation_enabled?
            if ::NewRelic::Agent::Instrumentation::MiddlewareProxy.needs_wrapping?(app)
              ::NewRelic::Agent.logger.info("We weren't able to instrument all of your Rack middlewares.",
                                            "To correct this, ensure you 'require \"newrelic_rpm\"' before setting up your middleware stack.")
            end
          end
        end
      end

      module RackBuilder
        def run_with_newrelic(app, *args)
          if ::NewRelic::Agent::Instrumentation::RackHelpers.middleware_instrumentation_enabled?
            wrapped_app = ::NewRelic::Agent::Instrumentation::MiddlewareProxy.wrap(app, true)
            run_without_newrelic(wrapped_app, *args)
          else
            run_without_newrelic(app, *args)
          end
        end

        def use_with_newrelic(middleware_class, *args, &blk)
          if ::NewRelic::Agent::Instrumentation::RackHelpers.middleware_instrumentation_enabled?
            wrapped_middleware_class = ::NewRelic::Agent::Instrumentation::MiddlewareProxy.for_class(middleware_class)
            use_without_newrelic(wrapped_middleware_class, *args, &blk)
          else
            use_without_newrelic(middleware_class, *args, &blk)
          end
        end

        # We patch this method for a reason that actually has nothing to do with
        # instrumenting rack itself. It happens to be a convenient and
        # easy-to-hook point that happens late in the startup sequence of almost
        # every application, making it a good place to do a final call to
        # DependencyDetection.detect!, since all libraries are likely loaded at
        # this point.
        def to_app_with_newrelic_deferred_dependency_detection
          unless ::Rack::Builder._nr_deferred_detection_ran
            NewRelic::Agent.logger.info "Doing deferred dependency-detection before Rack startup"
            DependencyDetection.detect!
            ::Rack::Builder._nr_deferred_detection_ran = true
          end

          result = to_app_without_newrelic
          ::NewRelic::Agent::Instrumentation::RackHelpers.check_for_late_instrumentation(result)

          result
        end
      end
    end
  end
end

DependencyDetection.defer do
  named :rack

  depends_on do
    defined?(::Rack) && defined?(::Rack::Builder)
  end

  executes do
    ::NewRelic::Agent.logger.info 'Installing deferred Rack instrumentation'

    class ::Rack::Builder
      class << self
        attr_accessor :_nr_deferred_detection_ran
      end
      self._nr_deferred_detection_ran = false

      include ::NewRelic::Agent::Instrumentation::RackBuilder

      alias_method :to_app_without_newrelic, :to_app
      alias_method :to_app, :to_app_with_newrelic_deferred_dependency_detection

      if ::NewRelic::Agent::Instrumentation::RackHelpers.middleware_instrumentation_enabled?
        ::NewRelic::Agent.logger.info 'Installing Rack::Builder middleware instrumentation'
        alias_method :run_without_newrelic, :run
        alias_method :run, :run_with_newrelic

        alias_method :use_without_newrelic, :use
        alias_method :use, :use_with_newrelic
      end
    end
  end
end

