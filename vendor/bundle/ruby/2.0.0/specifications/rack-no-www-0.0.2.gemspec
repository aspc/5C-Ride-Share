# -*- encoding: utf-8 -*-
# stub: rack-no-www 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "rack-no-www"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["logicaltext"]
  s.date = "2011-06-15"
  s.description = "Rack middleware for redirecting 'www' requests, based on the original idea by trevorturk (http://trevorturk.com/2009/11/05/no-www-rack-middleware/)."
  s.email = ["logicaltext@logicaltext.com"]
  s.homepage = "http://github.com/logicaltext/rack-no-www"
  s.rubyforge_project = "rack-no-www"
  s.rubygems_version = "2.4.1"
  s.summary = "Rack middleware for redirecting 'www' requests"

  s.installed_by_version = "2.4.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
  end
end
