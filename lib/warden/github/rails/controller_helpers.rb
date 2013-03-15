module Warden
  module GitHub
    module Rails
      module ControllerHelpers
        def self.included(klass)
          klass.helper_method(:github_authenticated?, :github_user)
        end

        # Initiates the OAuth flow if not already authenticated for the
        # specified scope.
        def github_authenticate!(scope=Rails.default_scope)
          request.env['warden'].authenticate!(:scope => scope)
        end

        # Logs out a user if currently logged in for the specified scope.
        def github_logout(scope=Rails.default_scope)
          request.env['warden'].logout(scope)
        end

        # Checks whether a user is logged in for the specified scope.
        def github_authenticated?(scope=Rails.default_scope)
          request.env['warden'].authenticated?(scope)
        end

        # Returns the currently signed in user for the specified scope. See the
        # documentation for Warden::GitHub::User for available methods.
        def github_user(scope=Rails.default_scope)
          request.env['warden'].user(scope)
        end

        # Accessor for the currently signed in user's session. This will be
        # cleared once logged out.
        def github_session(scope=Rails.default_scope)
          request.env['warden'].session(scope)  if github_authenticated?(scope)
        end
      end
    end
  end
end
