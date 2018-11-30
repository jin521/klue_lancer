
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "klue_lancer/version"

Gem::Specification.new do |spec|
  spec.name          = "klue_lancer"
  spec.version       = KlueLancer::VERSION
  spec.authors       = ["jin"]
  spec.email         = ["jean@shippit.com"]

  spec.summary       = %q{ A rubu gem to be connect with Freelancer API }
  spec.description   = %q{ A rubu gem to be connect with Freelancer API for Hackerthon Nov 2018 }
  spec.homepage      = "https://www.tobedecided.com"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard"
  spec.add_development_dependency 'guard-rspec', '~> 4.7', '>= 4.7.3'
  spec.add_development_dependency "pry"
  spec.add_development_dependency 'oauth2', '~> 1.4', '>= 1.4.1'
  spec.add_development_dependency 'faraday', '~> 0.15.4'
end
