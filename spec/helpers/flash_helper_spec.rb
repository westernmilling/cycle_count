require 'rails_helper'

RSpec.describe FlashHelper, type: :helper do
  describe '#flash_container' do
    subject { helper.flash_container(type, 'Test') }

    context 'when the type is a notice' do
      let(:type) { :notice }

      it { is_expected.to have_selector '.alert-success' }
    end
  end

  describe '#flash_messages' do
    subject { helper.flash_messages }

    context 'when the flash message is blank' do
      before do
        helper.flash.clear
      end

      it { is_expected.to be_blank }
    end

    context 'when the flash message is not blank' do
      before do
        helper.flash.notice = Faker::Lorem.sentence
      end

      it { is_expected.to_not be_blank }
    end
  end
end
