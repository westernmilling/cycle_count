class UpdateUser
  include Interactor

  before :find_user
  delegate :user, to: :context

  def call
    User.transaction do
      update_user
      user.save!
    end
    context.message = I18n.t('users.update.success')
  end

  protected

  def find_user
    context.user = User.find(context.id)
  end

  def update_user
    user.update_attributes(user_params)
  end

  def user_params
    context.to_h.slice(:email, :name, :is_active)
  end
end
