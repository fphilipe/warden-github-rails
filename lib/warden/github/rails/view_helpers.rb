module Warden
  module GitHub
    module Rails
      module ViewHelpers
        # Checks whether a user is logged in for the specified scope.
        def github_authenticated?(scope=Rails.default_scope)
          request.env['warden'].authenticated?(scope)
        end

        # Returns the currently signed in user for the specified scope. See the
        # documentation for Warden::GitHub::User for available methods.
        def github_user(scope=Rails.default_scope)
          request.env['warden'].user(scope)
        end
      end
    end
  end
end
