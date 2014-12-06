Gem::Specification.new do |spec|
  spec.name          = "lita-slack-handler"
  spec.version       = "1.0.0"
  spec.authors       = ["Ken J.", "Jimmy Cuadra"]
  spec.email         = ["kenjij@gmail.com", "jimmy@jimmycuadra.com"]
  spec.description   = %q{Lita handler for Slack. Deprecated. Use lita-slack instead.}
  spec.summary       = %q{Lita handler for Slack. Deprecated. Use lita-slack instead.}
  spec.homepage      = "https://github.com/kenjij/lita-slack-handler"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)

  spec.add_runtime_dependency "lita-slack", ">= 1.0.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
