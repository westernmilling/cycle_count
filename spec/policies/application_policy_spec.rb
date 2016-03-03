require 'rails_helper'

describe ApplicationPolicy, type: :policy do
  let(:user) { build(:user) }
  let(:record) { build(:user, :moderator) }

  subject { ApplicationPolicy.new(user, record) }

  describe 'index?' do
    it { is_expected.not_to permit_action(:index) }
  end

  describe 'show?' do
    it { is_expected.not_to permit_action(:show) }
  end

  describe 'new?' do
    it { is_expected.not_to permit_action(:new) }
  end

  describe 'create?' do
    it { is_expected.not_to permit_action(:create) }
  end

  describe 'edit?' do
    it { is_expected.not_to permit_action(:edit) }
  end

  describe 'update?' do
    it { is_expected.not_to permit_action(:update) }
  end

  describe 'destroy?' do
    it { is_expected.not_to permit_action(:destroy) }
  end

  describe 'scope' do
    its(:scope) { is_expected.to eq(Pundit.policy_scope(user, User)) }
  end

  describe '.scope' do
    subject { ApplicationPolicy::Scope.new(user, record).resolve }

    it { is_expected.to eq record }
  end
end
