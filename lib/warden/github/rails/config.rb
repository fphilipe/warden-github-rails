require 'active_support/core_ext/module/attribute_accessors'

module Warden
  module GitHub
    module Rails
      module Config
        # A cache of the warden config for the active manager.
        mattr_accessor :warden_config

        # Default scope to use when not explicitly specified.
        mattr_accessor :default_scope
        @@default_scope = :user

        # The list of scopes and their configs. This is used to add custom
        # configs to a specific scope. When using a scope that is not listed
        # here, it will use the default configs from warden-github.
        mattr_accessor :scopes
        @@scopes = {}

        # Adds a scope with custom configurations to the list of scopes.
        def self.add_scope(name, config={})
          scopes[name] = config
        end
      end
    end
  end
end
