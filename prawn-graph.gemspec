# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prawn/graph/version'

Gem::Specification.new do |spec|
  spec.name          = "prawn-graph"
  spec.version       = Prawn::Graph::VERSION
  spec.authors       = [
                          "Ryan Stenhouse",
                          "S. Hessam M. Mehr"
                        ]
  spec.email         = ["ryan@ryanstenhouse.jp"]
  spec.summary       = %q{An extension to Prawn that provides the ability to draw basic graphs and charts natively in your PDFs.}
  spec.description   = %q{Uses Prawn's built-in graphics primatives to allow you to draw rich and useful charts in your PDF documents.}
  spec.homepage      = "http://ryanstenhouse.jp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"

  spec.add_dependency "prawn", "~> 2"
end
