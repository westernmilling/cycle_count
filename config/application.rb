require File.expand_path('../boot', __FILE__)

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module CycleCountApp
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.test_framework :rspec, fixture: false
      g.view_specs false
      g.helper_specs false
    end

    config.secret_key_base = Figaro.env.SECRET_KEY_BASE
  end
end
