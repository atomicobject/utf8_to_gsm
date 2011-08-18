# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "utf8_to_gsm/version"

Gem::Specification.new do |s|
  s.name        = "utf8_to_gsm"
  s.version     = Utf8ToGsm::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Justin Kulesza","Matt Fletcher", "David Crosby", "Micah Alles"]
  s.email       = ["justin.kulesza@gmail.com","fletcher@atomicobject.com", "crosby@atomicobject.com", "alles@atomicobject.com"]
  s.homepage    = ""
  s.summary     = %q{`Utf8ToGsm` provides functionality to convert UTF-8 characters to their GSM equivalents.}
  s.description = %q{`Utf8ToGsm` provides functionality to convert UTF-8 characters to their GSM equivalents.}

  s.rubyforge_project = "utf8_to_gsm"

  s.add_dependency("unidecoder",">= 1.1.1")

  s.add_development_dependency("bundler", ">= 1.0.0")
  s.add_development_dependency("rake", ">= 0.8.0")
  s.add_development_dependency("yard", "~> 0.6.4")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
