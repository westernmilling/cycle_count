class ApplicationController < ActionController::Base
  include InteractorHandler
  include Pundit
  include Userstamp

  before_action :authenticate_user!
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    redirect_to(
      request.referer || root_path,
      alert: t('access_denied')
    )
  end
end
