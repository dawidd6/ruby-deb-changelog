Gem::Specification.new do |spec|
  spec.name          = "ruby-deb-changelog"
  spec.version       = "0.1.0"
  spec.authors       = ["Dawid Dziurla"]
  spec.email         = ["dawidd0811@gmail.com"]

  spec.summary       = "Debian changelog file parser"
  spec.homepage      = "https://github.com/dawidd6/ruby-deb-changelog"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files = `git ls-files`.split('\n')
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
