if Figaro.env.SMTP_SERVER.present?
  ActionMailer::Base.smtp_settings = {
    port: Figaro.env.SMTP_PORT,
    address: Figaro.env.SMTP_SERVER,
    user_name: Figaro.env.SMTP_LOGIN,
    password: Figaro.env.SMTP_PASSWORD,
    authentication: :plain
  }
  ActionMailer::Base.delivery_method = :smtp
end

ActionMailer::Base.smtp_settings ||= {}
ActionMailer::Base.smtp_settings.merge!(ENV.to_h.symbolize_keys.slice(:domain))
ActionMailer::Base.default_url_options[:host] = Figaro.env.DOMAIN
