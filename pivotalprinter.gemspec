# -*- encoding: utf-8 -*-
$:.unshift 'lib'
require "pivotalprinter/version"

Gem::Specification.new do |s|
  s.name        = "pivotalprinter"
  s.version     = Pivotalprinter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["pkw.de"]
  s.email       = ["dev@pkw.de"]
  s.homepage    = "http://pkw.de"
  s.summary     = %q{Story printer for pivotaltracker}
  s.description = %q{Generate nice story cards from pivotaltracker.}
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('term-ansicolor','>= 0.4.4')
  s.add_dependency('prawn','~>0.11.1')
  s.add_dependency('spruz','>= 0.2.0')
  s.add_dependency('trollop','>= 1.16.2')
  s.add_dependency('nokogiri','>= 1.4.4')
end
