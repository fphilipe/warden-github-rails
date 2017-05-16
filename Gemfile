source 'https://rubygems.org'

gemspec

if ENV['EDGE']
  gem 'warden-github', github: 'atmos/warden-github'
end

rails_version = ENV['RAILS_VERSION']

rails_opts = case rails_version
             when 'master'
               { github: 'rails/rails' }
             when nil
               {}
             else
               "~> #{rails_version}"
             end

gem "rails", rails_opts

group :development do
  unless ENV['CI']
    gem 'byebug', require: false
  end
end

platforms :rbx do
  gem 'rubysl'
  gem 'racc'
end
