if RUBY_ENGINE == 'ruby'
  if ENV['CI']
    require 'coveralls'
    Coveralls::Output.silent = true
    Coveralls.wear! do
      add_filter 'spec/'
      add_filter 'example/'
    end
  else
    require 'simplecov'
    SimpleCov.start
  end
end

require 'rack/test'
require 'warden/github/rails/test_helpers'
require 'addressable/uri'

# Load the test rails app:
ENV['RAILS_ENV'] ||= 'test'
require 'rails_app/config/environment'

# Setup configs needed to run:
ENV['GITHUB_CLIENT_ID']     = 'test_client_id'
ENV['GITHUB_CLIENT_SECRET'] = 'test_client_secret'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.order = 'random'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Rack::Test::Methods
  config.include Warden::GitHub::Rails::TestHelpers

  # Reset warden's login states after each test.
  config.after { Warden.test_reset! }

  # This is how rack-test gets access to the app.
  def app
    RailsApp::Application
  end
end
