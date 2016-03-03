require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  before do
    sign_in(build_stubbed(:user))

    allow(controller).to receive(:authorize) { authorized? }
    allow(controller).to receive(:pundit_policy_authorized?) { authorized? }
    allow(Location).to receive(:find) { location }
  end
  let(:location) { build_stubbed(:location) }

  describe 'GET index' do
    before do
      allow(controller).to receive(:locations) { locations }
      get :index
    end

    let(:authorized?) { true }
    let(:locations) { build_stubbed_list(:location, 2) }

    it_behaves_like 'a successful request'
    it_behaves_like 'an index request'
    it { expect(send(:locations)).to be_kind_of(Array) }
    it { expect(send(:locations)[0]).to be_kind_of(Location) }
    it { expect(send(:locations).size).to eq locations.size }
  end

  describe 'GET show' do
    before { get :show, id: location.id }
    let(:authorized?) { true }

    it_behaves_like 'a successful request'
    it_behaves_like 'a show request'
    it { expect(send(:location)).to be_kind_of(Location) }
  end

  describe 'GET new' do
    before { get :new }

    context 'when user is authorized' do
      let(:authorized?) { true }

      it_behaves_like 'a successful request'
      it_behaves_like 'a new request'
      it { expect(send(:location)).to be_kind_of(Location) }
    end

    context 'when user is not authorized' do
      let(:authorized?) { raise_pundit_error LocationPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'GET edit' do
    before { get :edit, id: location.id }

    context 'when authorized' do
      let(:authorized?) { true }

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit request'
      it { expect(send(:location)).to be_kind_of(Location) }
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error LocationPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'PATCH update' do
    before do
      allow(location).to receive(:update_attributes) { update? }

      patch :update, id: location.id, location: attributes_for(:location)
    end
    let(:update?) { fail 'update? not set' }

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:update?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(location_path(location)) }
      it do
        is_expected
          .to set_flash[:notice]
          .to I18n.t('locations.update.success')
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
          .to I18n.t('locations.update.failure')
      end
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error LocationPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'POST create' do
    before do
      allow(location).to receive(:save) { create? }
      allow(Location).to receive(:new) { location }

      post :create, location: nil
    end
    let(:location) { build_stubbed(:location) }
    let(:create?) { fail 'create? not set' }

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:create?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(location_path(location)) }
      it do
        is_expected
          .to set_flash[:notice]
          .to I18n.t('locations.create.success')
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
          .to I18n.t('locations.create.failure')
      end
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error LocationPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'DELETE destroy' do
    before do
      allow(location).to receive(:destroy) { destroy? }
      allow(Location).to receive(:find) { location }

      delete :destroy, id: location.id
    end

    let(:destroy?) { fail 'destroy? not set' }
    let(:location) { build_stubbed(:location) }

    context 'when the destroy is successful' do
      let(:authorized?) { true }
      let(:destroy?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(locations_path) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when the destroy is not successful' do
      let(:authorized?) { true }
      let(:destroy?) { false }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(locations_path) }
      it do
        is_expected
          .to set_flash[:alert]
          .to(I18n.t('locations.destroy.failure'))
      end
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error CycleCountPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end
end
