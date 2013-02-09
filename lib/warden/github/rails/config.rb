require 'active_support/core_ext/module/attribute_accessors'

module Warden
  module GitHub
    module Rails
      module Config
        # Default scope to use when not explicitly specified.
        mattr_accessor :default_scope
        @@default_scope = :user
      end
    end
  end
end
