class User < ActiveRecord::Base
  devise :database_authenticatable,
         :invitable,
         :recoverable,
         :rememberable,
         :trackable

  validates :name, presence: true

  def after_password_reset; end
end
