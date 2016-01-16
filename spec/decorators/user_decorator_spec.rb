require 'rails_helper'

describe UserDecorator, type: :decorator do
  let(:decorator) { build(:user, :moderator, is_active: is_active).decorate }

  describe '#active_label' do
    subject { decorator.active_label }

    context 'when is_active is nil' do
      let(:is_active) { nil }

      it { is_expected.to eq('Inactive') }
    end

    context 'when is_active is 0' do
      let(:is_active) { 0 }

      it { is_expected.to eq('Inactive') }
    end

    context 'when is_active is 1' do
      let(:is_active) { 1 }

      it { is_expected.to eq('Active') }
    end
  end
end
