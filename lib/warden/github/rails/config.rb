module Warden
  module GitHub
    module Rails
      class Config
        BadConfig = Class.new(StandardError)

        # Default scope to use when not explicitly specified.
        attr_accessor :default_scope

        # The list of scopes and their configs. This is used to add custom
        # configs to a specific scope. When using a scope that is not listed
        # here, it will use the default configs from warden-github.
        attr_reader :scopes

        # A hash containing team alias names and their numeric id.
        attr_reader :teams

        def initialize
          @default_scope = :user
          @scopes = {}
          @teams = {}
        end

        # Adds a scope with custom configurations to the list of scopes.
        def add_scope(name, config={})
          scopes[name] = config
        end

        # Maps a team id to a name in order to easier reference it.
        def add_team(name, id)
          teams[name.to_sym] = Integer(id)
        end

        # Gets the team id for a team id or alias.
        def team_id(team)
          # In ruby 1.8 doing a Integer(:symbol) returns an integer. Thus, test
          # for symbol first.
          if team.is_a? Symbol
            teams.fetch(team)
          else
            Integer(team)  rescue teams.fetch(team.to_sym)
          end
        rescue IndexError
          fail BadConfig, "No team id defined for team #{team}."
        end
      end
    end
  end
end
