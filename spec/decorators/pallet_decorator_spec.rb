require 'rails_helper'

describe PalletDecorator, type: :decorator do
  let(:decorator) do
    build(:pallet,
          created_at: created_at,
          updated_at: updated_at).decorate
  end
  let(:created_at) { Faker::Date.forward(30) }
  let(:updated_at) { Faker::Date.forward(30) }

  describe '#formatted_created_at' do
    subject { decorator.formatted_created_at }

    it { is_expected.to eq(created_at.strftime('%m/%d/%Y')) }
  end

  describe '#formatted_updated_at' do
    subject { decorator.formatted_updated_at }

    it { is_expected.to eq(updated_at.strftime('%m/%d/%Y')) }
  end
end
