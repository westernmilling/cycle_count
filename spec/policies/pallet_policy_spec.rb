require 'rails_helper'

describe PalletPolicy, type: :policy do
  let(:user) { build(:user, :moderator) }
  let(:pallet_to_manage) { build(:pallet) }

  subject { PalletPolicy.new(user, pallet_to_manage) }

  context 'when no user' do
    let(:user) { nil }

    it { is_expected.not_to permit_action(:index) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:new) }
    it { is_expected.not_to permit_action(:show) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'when user has no roles' do
    before { user.role_name = '' }

    it { is_expected.not_to permit_action(:index) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:new) }
    it { is_expected.not_to permit_action(:show) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'when user has the moderator role' do
    before { user.role_name = 'moderator' }

    it { is_expected.to permit_action(:index) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:new) }
    it { is_expected.not_to permit_action(:show) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'when user has the cycle_counter role' do
    before { user.role_name = 'cycle_counter' }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.not_to permit_action(:show) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'when user has the admin role' do
    before { user.role_name = 'admin' }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.not_to permit_action(:show) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  describe '.scope' do
    subject { PalletPolicy::Scope.new(user, pallet_to_manage).resolve }

    it { is_expected.to eq pallet_to_manage }
  end
end
