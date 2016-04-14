module Warden
  module GitHub
    module Rails
      module TestHelpers
        class MockUser < User
          attr_reader :memberships

          def initialize(*args)
            super
            @memberships = { team: [], org: [] }
          end

          def stub_membership(args)
            args.each do |type, values|
              values = Array(values)
              values.map!(&:to_i) if type == :team
              memberships.fetch(type).concat(values)
            end
          end

          def team_member?(id)
            memberships[:team].include?(id)
          end

          def organization_member?(id)
            memberships[:org].include?(id)
          end

          def marshal_dump
            [memberships, super]
          end

          def marshal_load(data)
            memberships, super_data = data
            @memberships = memberships.symbolize_keys
            super(super_data)
          end
        end
      end
    end
  end
end
