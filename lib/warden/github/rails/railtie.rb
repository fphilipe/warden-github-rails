module Warden
  module GitHub
    module Rails
      class Railtie < ::Rails::Railtie
        config.app_middleware.use Warden::Manager do |config|
          config.failure_app = lambda { |env| [403, {}, [env['warden'].message]] }
          Rails.config.warden_config = config
          Rails.config.scopes.each do |scope, scope_config|
            config.scope_defaults scope, :strategies => [:github],
                                         :config => scope_config
          end
        end
      end
    end
  end
end

