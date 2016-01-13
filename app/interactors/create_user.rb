class CreateUser
  include Interactor

  def call
    User.transaction do
      context.user = build_user
      context.user.save!
    end
    context.message = I18n.t('users.create.success')
  end

  protected

  def build_user
    User.new(user_params)
  end

  def user_params
    context.to_h.slice(:email, :name, :is_active)
  end
end
