require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 6.0

    # Railsアプリデフォルトのタイムゾーン(default 'UTC')
    config.time_zone = ENV["TZ"]
    config.i18n.default_locale = :ja
    config.active_record.default_timezone = :utc
    config.add_autoload_paths_to_load_path = false
    # config.middleware.use ActionDispatch::Cookies
    config.api_only = true
    config.autoload_paths += %W(#{config.root}/lib/validator)
  end
end
