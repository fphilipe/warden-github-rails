source 'https://rubygems.org'

gemspec

if ENV['DEBUG']
  gem 'warden-github', :path => '../warden-github/'
end

group :development do
  gem 'debugger',   :platforms => :ruby_19, :require => false
  gem 'ruby-debug', :platforms => :ruby_18, :require => false
end

