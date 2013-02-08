module Warden
  module GitHub
    module Rails
      class Railtie < ::Rails::Railtie
        config.app_middleware.use Warden::Manager do |config|
          config.failure_app = lambda { |env| [403, {}, [env['warden'].message]] }
          config.default_strategies :github
        end
      end
    end
  end
end

