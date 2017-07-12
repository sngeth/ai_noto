# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ai_noto/version'

Gem::Specification.new do |spec|
  spec.name          = "ai_noto"
  spec.version       = AiNoto::VERSION
  spec.authors       = ["Sid Ngeth"]
  spec.email         = ["sngeth@gmail.com"]

  spec.summary       = %q{A gem to send messagesto loved ones}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   << 'ainoto'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"

  spec.add_runtime_dependency 'twilio-ruby', '~> 5.0.0.rc26'
  spec.add_runtime_dependency 'thor'
end
