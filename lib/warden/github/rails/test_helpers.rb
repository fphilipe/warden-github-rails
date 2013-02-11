require 'warden/github'

module Warden
  module GitHub
    module Rails
      module TestHelpers
        include ::Warden::Test::Helpers

        # Login a mock GitHub user and return it.
        def github_login(scope=Rails.default_scope)
          MockUser.new.tap do |user|
            login_as(user, :scope => scope)
          end
        end
      end

      class MockUser < ::Warden::GitHub::User
        attr_reader :memberships

        def initialize(*args)
          super
          @memberships = { :team => [], :org => [], :org_public => [] }
        end

        def stub_membership(args)
          args.each do |key, value|
            memberships.fetch(key) << value
          end
        end

        def team_member?(id)
          memberships[:team].include?(id)
        end

        def organization_member?(id)
          memberships[:org].include?(id)
        end

        def organization_public_member?(id)
          memberships[:org_public].include?(id)
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
