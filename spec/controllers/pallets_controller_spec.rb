require 'rails_helper'

RSpec.describe PalletsController, type: :controller do
  before do
    sign_in(build_stubbed(:user))

    allow(controller).to receive(:authorize) { authorized? }
    allow(controller).to receive(:pundit_policy_authorized?) { authorized? }
    allow(Pallet).to receive(:find) { pallet }
  end
  let(:pallet) { build_stubbed(:pallet) }

  describe 'GET new' do
    before { get :new, cycle_count_id: pallet.cycle_count_id }

    context 'when user is authorized' do
      let(:authorized?) { true }

      it_behaves_like 'a successful request'
      it_behaves_like 'a new request'
      it { expect(send(:pallet)).to be_kind_of(Pallet) }
    end

    context 'when user is not authorized' do
      let(:authorized?) { raise_pundit_error PalletPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'POST create' do
    before do
      allow(CreatePallet).to receive(:call) { context }

      post :create, cycle_count_id: pallet.cycle_count_id, entry: pallet_params
    end

    let(:context) { double(pallet: pallet, message: '', success?: success?) }
    let(:success?) { fail 'success? not set' }
    let(:pallet_params) { attributes_for(:pallet) }

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:success?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(cycle_count_path(pallet.cycle_count_id)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when the call is not successful' do
      let(:authorized?) { true }
      let(:success?) { false }

      it_behaves_like 'a successful request'
      it_behaves_like 'a new request'
      it { is_expected.to set_flash[:alert] }
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error PalletPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'GET edit' do
    before { get :edit, cycle_count_id: pallet.cycle_count_id, id: pallet.id }

    context 'when user is authorized' do
      let(:authorized?) { true }

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit request'
      it { expect(send(:pallet)).to be_kind_of(Pallet) }
    end

    context 'when user is not authorized' do
      let(:authorized?) { raise_pundit_error PalletPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'PATCH update' do
    before do
      allow(pallet).to receive(:update_attributes) { update? }
      patch :update,
            cycle_count_id: pallet.cycle_count_id,
            id: pallet.id,
            pallet: attributes_for(:pallet)
    end

    let(:update?) { fail 'update? not set' }

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:update?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(cycle_count_path(pallet.cycle_count_id)) }
      it do
        is_expected
          .to set_flash[:notice]
          .to I18n.t('pallets.update.success')
      end
    end

    context 'when the call is not successful' do
      let(:authorized?) { true }
      let(:update?) { false }

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit request'
      it do
        is_expected
          .to set_flash[:alert]
          .to(I18n.t('pallets.update.failure'))
      end
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error PalletPolicy }
      let(:pallet_params) { nil }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end
end
