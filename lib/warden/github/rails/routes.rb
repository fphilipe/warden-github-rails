module Warden
  module GitHub
    module Rails
      module Routes
        # Enforces an authenticated GitHub user for the routes. If not
        # authenticated, it initiates the OAuth flow.
        #
        # Team and organization memberships can be checked by specifying a hash
        # such as `:team => 'foobar'` or `:org => 'my_company'`.
        def github_authenticate(scope=nil, options={}, &routes_block)
          github_constraint(scope, options, routes_block) do |warden, scope|
            warden.authenticate!(:scope => scope)
          end
        end

        # The routes will only be visible to authenticated GitHub users. When
        # not authenticated, it does not initiate the OAuth flow.
        #
        # Team and organization memberships can be checked by specifying a hash
        # such as `:team => 'foobar'` or `:org => 'my_company'`.
        def github_authenticated(scope=nil, options={}, &routes_block)
          github_constraint(scope, options, routes_block) do |warden, scope|
            warden.authenticated?(:scope => scope)
          end
        end

        # The routes will only be visible to all but authenticated GitHub users.
        #
        # This constraint currently does not check for memberships since of its
        # limited usage.
        def github_unauthenticated(scope=nil, options={}, &routes_block)
          github_constraint(scope, options, routes_block) do |warden, scope|
            not warden.authenticated?(:scope => scope)
          end
        end

        private

        def github_constraint(scope, options, routes_block, &block)
          options, scope = scope, nil  if scope.is_a? Hash
          scope ||= Rails.default_scope

          constraint = lambda do |request|
            warden = request.env['warden']

            if block.call(warden, scope)
              if (user = warden.user(scope))
                evaled_options = github_eval_options(options, request)
                github_enforce_options(user, evaled_options)
              else
                true
              end
            end
          end

          constraints(constraint, &routes_block)
        end

        def github_enforce_options(user, options)
          if (team = options[:team])
            user.team_member?(Rails.team_id(team))
          elsif (org = options[:org] || options[:organization])
            user.organization_member?(org)
          else
            true
          end
        end

        def github_eval_options(options, request)
          Hash[options.map { |k,v|
            if v.is_a?(Proc)
              [k, v.call(request)]
            else
              [k, v]
            end
          }]
        end
      end
    end
  end
end

ActionDispatch::Routing::Mapper.send(:include, Warden::GitHub::Rails::Routes)
