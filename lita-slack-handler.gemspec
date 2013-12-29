Gem::Specification.new do |spec|
  spec.name          = "lita-slack-handler"
  spec.version       = "0.1.0"
  spec.authors       = ["Ken J."]
  spec.email         = ["kenjij@gmail.com"]
  spec.description   = %q{Lita handler for Slack}
  spec.summary       = %q{Lita handler for Slack; complement lita-slack adapter gem.}
  spec.homepage      = "https://github.com/kenjij/lita-slack-handler"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", "~> 2.7"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 2.14"
end
