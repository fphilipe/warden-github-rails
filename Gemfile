source 'https://rubygems.org'

gemspec

if ENV['EDGE']
  gem 'warden-github', :github => 'atmos/warden-github'
end

rails_version = ENV['RAILS_VERSION']

rails_opts = case rails_version
             when 'master'
               { :github => 'rails/rails' }
             when nil
               {}
             else
               "~> #{rails_version}"
             end

gem "rails", rails_opts

group :development do
  unless ENV['CI']
    gem 'debugger',   :platforms => :ruby_19, :require => false
    gem 'ruby-debug', :platforms => :ruby_18, :require => false
  end
end
