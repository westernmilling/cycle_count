class UserEntry < FormEntry
  attribute :email, String
  attribute :name, String
  attribute :is_active, Integer

  validates :email, :name, presence: true
  validate :unique?

  def persisted?
    false
  end

  def unique?
    errors.add(:email, I18n.t('users.create.invalid')) if \
      User.find_by(email: email)
  end
end
