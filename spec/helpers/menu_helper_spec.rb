require 'rails_helper'

RSpec.describe MenuHelper, type: :helper do
  describe '#menu' do
    subject { helper.menu }
    before do
      allow(helper)
        .to receive(:current_user)
        .and_return(user)
      allow(helper).to receive(:user_signed_in?).and_return(signed_in)
    end

    context 'when a user is not signed in' do
      let(:signed_in) { false }
      let(:user) { nil }

      it { is_expected.to have_selector 'ul' }
      it { is_expected.to have_selector 'ul li' }
      it { is_expected.to have_selector 'ul li a' }
      it { is_expected.to have_content I18n.t('devise.sign_in') }
    end

    context 'when a user is signed in' do
      let(:signed_in) { true }
      let(:user) { build_stubbed(:user) }

      it { is_expected.to have_selector 'ul' }
      it { is_expected.to have_selector 'ul li', count: 2 }
      it { is_expected.to have_selector 'ul li a', count: 2 }
      it { is_expected.to have_content I18n.t('devise.sign_out') }
      it { is_expected.to have_content user.name }
    end
  end
end
