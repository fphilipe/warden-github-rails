lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'warden/github/rails/version'

Gem::Specification.new do |gem|
  gem.name          = 'warden-github-rails'
  gem.version       = Warden::GitHub::Rails::VERSION
  gem.authors       = ['Philipe Fatio']
  gem.email         = ['me@phili.pe']
  gem.summary       = %q{An easy drop in solution for rails to use GitHub authentication.}
  gem.description   = gem.summary
  gem.homepage      = 'https://github.com/fphilipe/warden-github-rails'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rspec', '~> 2.12'
  gem.add_development_dependency 'simplecov'

  gem.add_dependency 'warden-github', '~> 0.13'
end
