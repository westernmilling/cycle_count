require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  before do
    allow(controller).to receive(:authorize) { authorized? }
    allow(controller).to receive(:pundit_policy_authorized?) { authorized? }

    sign_in(user)
  end

  let(:user) { build_stubbed(:user) }
  let(:location) { create(:location) }

  describe 'GET index' do
    before { get :index }
    let(:authorized?) { true }

    it_behaves_like 'a successful request'
    it_behaves_like 'an index request'
  end

  describe 'GET show' do
    before { get :show, id: location.id }
    let(:authorized?) { true }

    it_behaves_like 'a successful request'
    it_behaves_like 'a show request'
  end

  describe 'GET new' do
    before { get :new }

    context 'when user is authorized' do
      let(:authorized?) { true }

      it_behaves_like 'a successful request'
      it_behaves_like 'a new request'
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
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error LocationPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'PATCH update' do
    before do
      patch :update,
            id: location.id,
            location: location_params
    end

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:location_params) { attributes_for(:location) }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(location_path(location)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when the call is not successful' do
      let(:authorized?) { true }
      let(:location_params) { attributes_for(:location, location_number: nil) }

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit request'
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error LocationPolicy }
      let(:location_params) { nil }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'POST create' do
    before do
      post :create,
           location: location_params
    end

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:location_params) { attributes_for(:location) }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(location_path(assigns(:location))) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when the call is not successful' do
      let(:authorized?) { true }
      let(:location_params) { attributes_for(:location, location_number: nil) }

      it_behaves_like 'a successful request'
      it_behaves_like 'a new request'
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error LocationPolicy }
      let(:location_params) { nil }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'DELETE destroy' do
    before do
      xhr :delete, :destroy, id: location.id
    end

    context 'when the destroy is successful' do
      let(:authorized?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(locations_path) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error LocationPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end
end
