require 'rails_helper'

describe UserDecorator, type: :decorator do
  let(:decorator) do
    build(:user,
          :moderator,
          is_active: is_active,
          created_at: created_at,
          updated_at: updated_at
         ).decorate
  end
  let(:created_at) { Faker::Date.forward(30) }
  let(:updated_at) { Faker::Date.forward(30) }
  let(:is_active) { 0 }

  describe '#formatted_created_at' do
    subject { decorator.formatted_created_at }

    it { is_expected.to eq(created_at.strftime('%m/%d/%Y')) }
  end

  describe '#formatted_updated_at' do
    subject { decorator.formatted_updated_at }

    it { is_expected.to eq(updated_at.strftime('%m/%d/%Y')) }
  end

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
