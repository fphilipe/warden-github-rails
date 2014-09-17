require 'warden/github'
require 'warden/github/rails/test_helpers/mock_user'

module Warden
  module GitHub
    module Rails
      module TestHelpers
        include ::Warden::Test::Helpers

        # Login a mock GitHub user and return it.
        def github_login(scope=Rails.default_scope)
          MockUser.new.tap do |user|
            login_as(user, scope: scope)
          end
        end
      end
    end
  end
end

# Add a method to Rack::Response::Helpers to easily determine if a request
# resulted in an OAuth redirect to GitHub.
module Rack::Response::Helpers
  def github_oauth_redirect?
    redirect? && %r{https?://[^/]+/login/oauth/authorize\b} =~ location
  end
end
