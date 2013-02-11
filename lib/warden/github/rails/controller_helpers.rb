module Warden
  module GitHub
    module Rails
      module ControllerHelpers
        def github_authenticate!(scope=Rails.default_scope)
          request.env['warden'].authenticate!(:scope => scope)
        end

        def github_logout(scope=Rails.default_scope)
          request.env['warden'].logout(scope)
        end

        def github_authenticated?(scope=Rails.default_scope)
          request.env['warden'].authenticated?(scope)
        end

        def github_user(scope=Rails.default_scope)
          request.env['warden'].user(scope)
        end

        def github_session(scope=Rails.default_scope)
          request.env['warden'].session(scope)  if github_authenticated?(scope)
        end
      end
    end
  end
end
