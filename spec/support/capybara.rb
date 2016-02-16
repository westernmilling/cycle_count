require 'capybara/rails'

Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.allow_url('gravatar.com')
end
