# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "muffins/version"

Gem::Specification.new do |s|
  s.name        = "muffins"
  s.version     = Muffins::VERSION
  s.authors     = ["Ryan Closner"]
  s.email       = ["ryan@ryanclosner.com"]
  s.homepage    = "http://rubygems.org/gems/muffins"
  s.summary     = %q{An Object to XML/HTML mapping library.}
  s.description = %q{An Object to XML/HTML mapping library using Virtus and Nokogiri}

  s.rubyforge_project = "muffins"

  runtime_dependencies = {
    'nokogiri'  => '~> 1.5.0',
    'virtus'    => '~> 0.0.9'
  }

  runtime_dependencies.each {|lib, version| s.add_runtime_dependency(lib, version) }

  development_dependencies = {
    'rspec'  => '~> 2.7.0'
  }

  development_dependencies.each {|lib, version| s.add_development_dependency(lib, version) }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
