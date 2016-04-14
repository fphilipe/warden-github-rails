module Warden
  module GitHub
    module Rails
      class Railtie < ::Rails::Railtie
        SERIALIZE_FROM_SESSION = -> ((class_name, data)) do
          class_name.constantize.new.tap { |user| user.marshal_load(data) }
        end
        SERIALIZE_INTO_SESSION = -> (user) do
          [user.class.name, user.marshal_dump]
        end

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
              config.intercept_401 = false
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
            config.scope_defaults scope, strategies: [:github],
                                         config: scope_config
            config.serialize_from_session(scope, &SERIALIZE_FROM_SESSION)
            config.serialize_into_session(scope, &SERIALIZE_INTO_SESSION)
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
