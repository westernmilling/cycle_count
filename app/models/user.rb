class User < ActiveRecord::Base
  devise :database_authenticatable,
         :invitable,
         :recoverable,
         :rememberable,
         :trackable

  model_stamper

  ROLE_NAMES = %w(
    admin
    moderator
    cycle_counter
  ).freeze

  validates :email, :name, :role_name, presence: true
  validates :email, uniqueness: true, case_sensitive: false

  def after_password_reset; end
end
