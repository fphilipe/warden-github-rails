require 'warden'

module Warden
  module GitHub
    module Rails
      module TestHelpers
        include ::Warden::Test::Helpers

        # Login a mock GitHub user.
        def github_login(scope=Config.default_scope)
          login_as('github user', :scope => scope)
        end
      end
    end
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
