Devise.setup do |config|
  require 'devise/orm/active_record'
  config.secret_key = Figaro.env.SECRET_KEY_BASE
  config.mailer_sender = Figaro.env.MAILER_SENDER
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.validate_on_invite = true
  config.allow_insecure_sign_in_after_accept = false
  config.remember_for = 2.weeks
  config.expire_all_remember_me_on_sign_out = true
  config.extend_remember_period = true
  config.password_length = 8..128
  config.lock_strategy = :failed_attempts
  config.unlock_keys = [:email]
  config.unlock_strategy = :both
  config.maximum_attempts = 20
  config.unlock_in = 1.hour
  config.last_attempt_warning = true
  config.reset_password_within = 6.hours
  config.scoped_views = true
  config.sign_out_via = :delete
end
