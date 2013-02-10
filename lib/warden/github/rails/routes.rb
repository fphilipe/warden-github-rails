module Warden
  module GitHub
    module Rails
      module Routes
        # Enforces an authenticated GitHub user for the routes. If not
        # authenticated, it initiates the OAuth flow.
        def github_authenticate(scope=Rails.config.default_scope)
          constraint = lambda do |request|
            request.env['warden'].authenticate!(:scope => scope)
          end

          constraints(constraint) do
            yield
          end
        end

        # The routes will only be visible to authenticated GitHub users. When
        # not authenticated, it does not initiate the OAuth flow.
        def github_authenticated(scope=Rails.config.default_scope)
          constraint = lambda do |request|
            request.env["warden"].authenticated?(:scope => scope)
          end

          constraints(constraint) do
            yield
          end
        end

        # The routes will only be visible to all but authenticated GitHub users.
        def github_unauthenticated(scope=Rails.config.default_scope)
          constraint = lambda do |request|
            not request.env["warden"].authenticated?(:scope => scope)
          end

          constraints(constraint) do
            yield
          end
        end
      end
    end
  end
end

ActionDispatch::Routing::Mapper.send(:include, Warden::GitHub::Rails::Routes)
