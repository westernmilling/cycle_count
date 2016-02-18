require 'rails_helper'

RSpec.describe CycleCountsController, type: :controller do
  before do
    sign_in(build_stubbed(:user))

    allow(controller).to receive(:authorize) { authorized? }
    allow(controller).to receive(:pundit_policy_authorized?) { authorized? }
    allow(CycleCount).to receive(:find) { cycle_count }
  end

  let(:cycle_count) { build_stubbed(:cycle_count) }

  describe 'GET index' do
    before do
      allow(controller).to receive(:cycle_counts) { cycle_counts }
      get :index
    end
    let(:authorized?) { true }
    let(:cycle_counts) { build_stubbed_list(:cycle_count, 2) }

    it_behaves_like 'a successful request'
    it_behaves_like 'an index request'
    it { expect(send(:cycle_counts)).to be_kind_of(Array) }
    it { expect(send(:cycle_counts)[0]).to be_kind_of(CycleCount) }
    it { expect(send(:cycle_counts).size).to eq(cycle_counts.size) }
  end

  describe 'GET show' do
    before { get :show, id: cycle_count.id }
    let(:authorized?) { true }

    it_behaves_like 'a successful request'
    it_behaves_like 'a show request'
    it { expect(send(:cycle_count)).to be_kind_of(CycleCount) }
  end

  describe 'GET new' do
    before { get :new }

    context 'when user is authorized' do
      let(:authorized?) { true }

      it_behaves_like 'a successful request'
      it_behaves_like 'a new request'
      it { expect(send(:cycle_count)).to be_kind_of(CycleCount) }
    end

    context 'when user is not authorized' do
      let(:authorized?) { raise_pundit_error CycleCountPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'GET edit' do
    before { get :edit, id: cycle_count.id }

    context 'when authorized' do
      let(:authorized?) { true }

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit request'
      it { expect(send(:cycle_count)).to be_kind_of(CycleCount) }
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error CycleCountPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'PATCH update' do
    before do
      allow(cycle_count).to receive(:update_attributes) { update? }
      patch :update,
            id: cycle_count.id,
            cycle_count: attributes_for(:cycle_count)
    end

    let(:update?) { fail 'update? not set' }

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:update?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(cycle_count_path(cycle_count)) }
      it do
        is_expected
          .to set_flash[:notice]
          .to I18n.t('cycle_counts.update.success')
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
          .to(I18n.t('cycle_counts.update.failure'))
      end
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error CycleCountPolicy }
      let(:cycle_count_params) { nil }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'POST create' do
    before do
      allow(cycle_count).to receive(:save) { create? }
      allow(CycleCount).to receive(:new) { cycle_count }

      post :create, cycle_count: nil
    end

    let(:cycle_count) { build_stubbed(:cycle_count) }
    let(:create?) { fail 'create? not set' }

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:create?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(cycle_count_path(cycle_count)) }
      it do
        is_expected
          .to set_flash[:notice]
          .to I18n.t('cycle_counts.create.success')
      end
    end

    context 'when the call is not successful' do
      let(:authorized?) { true }
      let(:create?) { false }

      it_behaves_like 'a successful request'
      it_behaves_like 'a new request'
      it do
        is_expected
          .to set_flash[:alert]
          .to(I18n.t('cycle_counts.create.failure'))
      end
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error CycleCountPolicy }
      let(:cycle_count_params) { nil }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'DELETE destroy' do
    before do
      allow(cycle_count).to receive(:destroy) { destroy? }
      allow(CycleCount).to receive(:find) { cycle_count }

      delete :destroy, id: cycle_count.id
    end

    let(:destroy?) { fail 'destroy? not set' }
    let(:cycle_count) { build_stubbed(:cycle_count) }

    context 'when the destroy is successful' do
      let(:authorized?) { true }
      let(:destroy?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(cycle_counts_path) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when the destroy is not successful' do
      let(:authorized?) { true }
      let(:destroy?) { false }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(cycle_counts_path) }
      it do
        is_expected
          .to set_flash[:alert]
          .to(I18n.t('cycle_counts.destroy.failure'))
      end
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error CycleCountPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end
end
