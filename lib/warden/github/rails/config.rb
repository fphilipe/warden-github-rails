module Warden
  module GitHub
    module Rails
      class Config
        # A cache of the warden config for the active manager.
        attr_accessor :warden_config

        # Default scope to use when not explicitly specified.
        attr_accessor :default_scope

        # The list of scopes and their configs. This is used to add custom
        # configs to a specific scope. When using a scope that is not listed
        # here, it will use the default configs from warden-github.
        attr_reader :scopes

        def initialize
          @scopes = {}
          @default_scope = :user
        end

        # Adds a scope with custom configurations to the list of scopes.
        def add_scope(name, config={})
          scopes[name] = config
        end
      end
    end
  end
end
