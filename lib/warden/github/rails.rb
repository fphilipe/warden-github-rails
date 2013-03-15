require 'warden/github'

require 'warden/github/rails/version'
require 'warden/github/rails/routes'
require 'warden/github/rails/railtie'
require 'warden/github/rails/config'
require 'warden/github/rails/controller_helpers'

require 'forwardable'

module Warden
  module GitHub
    module Rails
      extend SingleForwardable

      def_delegators :config,
                     :default_scope,
                     :scopes,
                     :team_id

      @config = Config.new

      def self.config
        @config
      end

      # Use this method to setup this gem.
      #
      # @example
      #
      #   Warden::GitHub::Rails.setup do |config|
      #     # ...
      #   end
      def self.setup
        yield config
      end
    end
  end
end
