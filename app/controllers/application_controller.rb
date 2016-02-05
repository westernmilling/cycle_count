class ApplicationController < ActionController::Base
  include InteractorHandler
  include Pundit

  before_action :authenticate_user!
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    redirect_to(
      request.referrer || root_path,
      alert: t('access_denied'))
  end

  def error_messages(object)
    return nil if object.errors.blank?

    content_tag 'div',
                class: 'alert alert-danger',
                role: 'alert' do
      concat content_tag('strong', 'There were errors with your submission.')
      concat(
        content_tag('ul', class: 'errors') do
          object
            .errors
            .full_messages
            .each { |message| concat content_tag('li', message) }
        end
      )
    end
  end
end
