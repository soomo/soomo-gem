# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "soomo/version"

Gem::Specification.new do |s|
  s.name        = "soomo"
  s.version     = Soomo::VERSION
  s.authors     = ["Matthew Bennink"]
  s.email       = ["matt@soomopublishing.com"]
  s.homepage    = ""
  s.summary     = %q{Soomo gem.}
  s.description = %q{Soomo gem.}

  s.rubyforge_project = "soomo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"

  s.add_dependency "oauth"
end
