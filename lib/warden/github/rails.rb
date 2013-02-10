require 'warden/github'
require 'warden/github/rails/version'
require 'warden/github/rails/routes'
require 'warden/github/rails/railtie'
require 'warden/github/rails/config'

module Warden
  module GitHub
    module Rails
      @@config = Config.new

      def self.config
        @@config
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
