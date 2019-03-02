require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Webapp
  class Application < Rails::Application
    config.load_defaults 5.2

    config.generators do |g|
      g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end

    config.cache_store = :redis_store, {
      host: ENV['REDIS_HOST'] || 'localhost',
      port: 6379,
      db: 0,
      password: ENV['REDIS_PASS'] || '',
      namespace: 'cache'
    }, {
      expires_in: 1.days
    }

    config.session_store :redis_store, {
      servers: [
        {
          host: ENV['REDIS_HOST'] || 'localhost',
          port: 6379,
          db: 0,
          password: ENV['REDIS_PASS'] || '',
          namespace: 'session'
        },
      ],
      expire_after: 2.days
    }
  end
end
