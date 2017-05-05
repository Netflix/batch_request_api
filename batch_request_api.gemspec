lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'batch_request_api/version'
Gem::Specification.new do |spec|
  spec.name          = 'batch_request_api'
  spec.version       = BatchRequestApi::VERSION
  spec.authors       = ["Srinivas Raghunathan", "Shishir Kakaraddi"]
  spec.email         = ["sraghunathan@netflix.com", "skakaraddi@netflix.com"]
  spec.summary       = %q{Batch API middleware.}
  spec.description   = %q{Batch API middleware.}
  spec.homepage      = "https://github.com/Netflix/batch_request_api"
  spec.license       = "Apache 2"
  spec.require_paths = ["lib"]
end
