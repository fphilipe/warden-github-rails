require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'warden/github/rails'

unless Rails.env.test?
  begin
    require 'debugger'
  rescue LoadError
    require 'ruby-debug'
  end
end

module RailsApp
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
  end
end
