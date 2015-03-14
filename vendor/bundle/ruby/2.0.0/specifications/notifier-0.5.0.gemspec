# -*- encoding: utf-8 -*-
# stub: notifier 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "notifier"
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nando Vieira"]
  s.date = "2014-04-30"
  s.description = "Send system notifications on several platforms with a simple and unified API. Currently supports Growl, Libnotify, OSD, KDE (Knotify and Kdialog) and Snarl"
  s.email = ["fnando.vieira@gmail.com"]
  s.homepage = "http://rubygems.org/gems/notifier"
  s.requirements = ["Growl, terminal-notifier, Libnotify, OSD, KDE (Knotify and Kdialog) or Snarl"]
  s.rubygems_version = "2.4.1"
  s.summary = "Send system notifications on several platforms with a simple and unified API. Currently supports Growl, Libnotify, OSD, KDE (Knotify and Kdialog) and Snarl"

  s.installed_by_version = "2.4.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
