# -*- encoding: utf-8 -*-
# stub: test_notifier 2.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "test_notifier"
  s.version = "2.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nando Vieira"]
  s.date = "2014-06-11"
  s.description = "Display system notifications (dbus, growl and snarl) after\nrunning tests. It works on Mac OS X, Linux and Windows. Powerful when used\nwith Autotest ZenTest gem and alike for Rails apps.\n"
  s.email = ["fnando.vieira@gmail.com"]
  s.homepage = "http://rubygems.org/gems/test_notifier"
  s.rubygems_version = "2.4.1"
  s.summary = "Display system notifications (dbus, growl and snarl) after running tests."

  s.installed_by_version = "2.4.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<notifier>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 3.0.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<notifier>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 3.0.0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<notifier>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 3.0.0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
