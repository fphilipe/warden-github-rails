require 'simplecov'
SimpleCov.start do
  add_filter '/spec'
  add_filter '/example'
end

require 'rack/test'

# Load the test rails app:
require 'rails_app/config/environment'

# Setup configs needed to run:
ENV['GITHUB_CLIENT_ID']     = 'test_client_id'
ENV['GITHUB_CLIENT_SECRET'] = 'test_client_secret'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.include Rack::Test::Methods
  config.include Warden::Test::Helpers

  # Reset warden's login states after each test.
  config.after { Warden.test_reset! }

  # This is how rack-test gets access to the app.
  def app
    RailsApp::Application
  end
end

# Add a method to Rack::Response to easily determine if a request resulted in an
# OAuth redirect to GitHub.
class Rack::Response
  def github_oauth_redirect?
    redirect? and
      location.start_with?('https://github.com/login/oauth/authorize')
  end
end
