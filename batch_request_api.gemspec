lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'batch_request_api/version'
Gem::Specification.new do |spec|
  spec.name          = 'batch_request_api'
  spec.version       = BatchRequestApi::VERSION
  spec.authors       = ["Srinivas Raghunathan", "Shishir Kakaraddi"]
  spec.email         = ["sraghunathan@netflix.com", "skakaraddi@netflix.com"]
  spec.summary       = %q{Rails Batch Request API.}
  spec.description   = %q{Batch API middleware.}
  spec.homepage      = "https://github.com/Netflix/batch_request_api"
  spec.license       = "Apache-2.0"
  spec.require_paths = ["lib"]
  spec.files         = `git ls-files lib`.split($/)

  spec.add_dependency 'rails', '>= 4.0'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
