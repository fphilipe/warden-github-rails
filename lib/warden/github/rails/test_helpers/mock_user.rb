module Warden
  module GitHub
    module Rails
      module TestHelpers
        class MockUser < User
          attr_reader :memberships

          def initialize(*args)
            super
            @memberships = { :team => [], :org => [] }
          end

          def stub_membership(membership)
            memberships.fetch(membership.keys.first) << membership.values.first
          end

          def team_member?(id)
            memberships[:team].include?(id)
          end

          def organization_member?(id)
            memberships[:org].include?(id)
          end
        end
      end
    end
  end
end
