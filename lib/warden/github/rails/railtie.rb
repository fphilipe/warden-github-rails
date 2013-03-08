module Warden
  module GitHub
    module Rails
      class Railtie < ::Rails::Railtie
        config.app_middleware.use Warden::Manager do |config|
          config.failure_app = lambda { |env| [403, {}, [env['warden'].message]] }
          Rails.scopes.each do |scope, scope_config|
            config.scope_defaults scope, :strategies => [:github],
                                         :config => scope_config
          end
        end

        initializer 'warden-github-rails.helpers' do
          ActiveSupport.on_load(:action_controller) do
            include ControllerHelpers
          end

          ActiveSupport.on_load(:action_view) do
            include ViewHelpers
          end
        end
      end
    end
  end
end

