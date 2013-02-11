module Warden
  module GitHub
    module Rails
      module Routes
        # Enforces an authenticated GitHub user for the routes. If not
        # authenticated, it initiates the OAuth flow.
        def github_authenticate(scope=nil, options={}, &routes_block)
          github_constraint(scope, options, routes_block) do |warden, scope|
            warden.authenticate!(:scope => scope)
          end
        end

        # The routes will only be visible to authenticated GitHub users. When
        # not authenticated, it does not initiate the OAuth flow.
        def github_authenticated(scope=nil, options={}, &routes_block)
          github_constraint(scope, options, routes_block) do |warden, scope|
            warden.authenticated?(:scope => scope)
          end
        end

        # The routes will only be visible to all but authenticated GitHub users.
        def github_unauthenticated(scope=nil, options={}, &routes_block)
          github_constraint(scope, options, routes_block) do |warden, scope|
            not warden.authenticated?(:scope => scope)
          end
        end

        private

        def github_constraint(scope, options, routes_block, &block)
          constraint = lambda do |request|
            if block.call(request.env['warden'], scope || Rails.default_scope)
              github_enforce_options(options)
            end
          end

          constraints(constraint, &routes_block)
        end

        def github_enforce_options(options)
          true
        end
      end
    end
  end
end

ActionDispatch::Routing::Mapper.send(:include, Warden::GitHub::Rails::Routes)
