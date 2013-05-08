module Warden
  module GitHub
    module Rails
      class Railtie < ::Rails::Railtie
        initializer 'warden-github-rails.warden' do |app|
          # When devise is used, it inserts a warden middlware. Multiple warden
          # middlewares do not work properly. Devise allows for a block to be
          # specified that is invoked when its warden middleware is configured.
          # This makes it possible to setup warden-github-rails through devise.
          if defined?(::Devise)
            ::Devise.warden { |config| setup_scopes(config) }
          else
            app.config.middleware.use Warden::Manager do |config|
              setup_failure_app(config)
              setup_scopes(config)
            end
          end
        end

        initializer 'warden-github-rails.helpers' do
          ActiveSupport.on_load(:action_controller) do
            include ControllerHelpers
          end
        end

        def setup_scopes(config)
          Rails.scopes.each do |scope, scope_config|
            config.scope_defaults scope, :strategies => [:github],
                                         :config => scope_config
          end
        end

        def setup_failure_app(config)
          config.failure_app = lambda do |env|
            [403, {}, [env['warden'].message]]
          end
        end
      end
    end
  end
end

