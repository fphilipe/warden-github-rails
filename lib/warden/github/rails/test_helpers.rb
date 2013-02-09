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
