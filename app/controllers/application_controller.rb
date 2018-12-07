class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :setup_application_controller_environment
  before_filter :current_user

  def sort_rides(rides)
    if rides
      rides.find_all{|ride| ride.flighttime > Time.now}.sort_by!(&:flighttime)
    else
      nil
    end
  end

  protected

    def current_user
      @current_user ||= User.find_by_id(session[:current_user_id]) if session[:current_user_id]

      @current_user
    end

    def signed_in?
      !!current_user
    end

    def checker
      unless current_user
        redirect_to root_url
      end
    end

    def login_helper
      unless signed_in?
        session[:redirect_to] = :back
        redirect_to login_path
      end
    end

    helper_method :current_user, :signed_in?, :checker

    def current_user=(user)
      @current_user = user
      session[:current_user_id] = user.id
    end

    def setup_application_controller_environment
      if(Rails.env.development?)
        # Login as a fake user in development mode
        # NOTE: this user will _never_ be available in production
        dev_user = User.find_or_create_by(:email => "dev_user@pomonastudents.org",
                                          :name => "Dev User",
                                          :is_cas_authenticated => false,
                                          :is_admin => true,
                                          :school => User.schools[:pomona],
                                          :password => "dev_password");

        session[:current_user_id] = dev_user.id
      end
    end

end
