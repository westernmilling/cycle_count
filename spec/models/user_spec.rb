require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user, :moderator) }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :role_name }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
end
