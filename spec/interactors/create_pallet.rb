require 'rails_helper'

RSpec.describe CreatePallet, type: :interactor do
  describe '.call' do
    let(:context) { CreatePallet.call(pallet.attributes) }
    let(:pallet) { build(:pallet) }

    context 'when the save fails' do
      before do
        allow(Pallet)
          .to receive(:where)
          .and_return(count: 1)
      end

      subject { context }

      its(:success?) { is_expected.to be false }
      its(:message) do
        is_expected.to eq I18n.t('pallets.create.failure')
      end
    end

    context 'when the save succeeds' do
      before do
        allow(context.pallet)
          .to receive(:save!)
          .and_return(true)
        allow(Pallet)
          .to receive(:where)
          .and_return(count: 0)
      end

      subject { context }

      its(:success?) { is_expected.to be true }
      its(:message) do
        is_expected.to eq I18n.t('pallets.create.success')
      end
    end
  end
end
