source 'https://rubygems.org'

gemspec

if ENV['EDGE']
  gem 'warden-github', :github => 'atmos/warden-github'
end

group :development do
  unless ENV['CI']
    gem 'debugger',   :platforms => :ruby_19, :require => false
    gem 'ruby-debug', :platforms => :ruby_18, :require => false
  end
end
