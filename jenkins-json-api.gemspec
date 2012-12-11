# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jenkins-json-api/version'

Gem::Specification.new do |gem|
  gem.name          = "jenkins-json-api"
  gem.version       = Jenkins::Json::Api::VERSION
  gem.authors       = ["Marton Suranyi"]
  gem.email         = ["marton.suranyi@gmail.com"]
  gem.description   = %q{Ruby wrapper for Jenkins JSON API}
  gem.summary       = %q{Very experimental!}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
