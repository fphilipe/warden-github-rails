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

  gem.files         = `git ls-files`.split($/) - Dir.glob('example/**/*')
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_development_dependency 'rspec', '~> 3.1'
  gem.add_development_dependency 'rails', '>= 3.2'
  gem.add_development_dependency 'rack-test', '~> 0.6'
  gem.add_development_dependency 'addressable', '~> 2.3'
  gem.add_development_dependency 'coveralls' if RUBY_ENGINE == 'ruby'

  gem.add_dependency 'warden-github', '~> 1.1', '>= 1.1.1'
  gem.add_dependency 'railties', '>= 3.1'
end
