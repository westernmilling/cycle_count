require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  before do
    allow(controller).to receive(:authorize) { authorized? }
    allow(controller).to receive(:pundit_policy_authorized?) { authorized? }

    sign_in(user)
  end

  let(:user) { build_stubbed(:user) }

  describe 'GET edit' do
    before { get :edit, id: user.id }

    context 'when authorized' do
      let(:authorized?) { true }
      let(:user) { create(:user, :admin) }

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit request'
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error UserPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'GET index' do
    before { get :index }

    context 'when authorized' do
      let(:authorized?) { true }
      let(:user) { create(:user, :admin) }

      it_behaves_like 'a successful request'
      it_behaves_like 'an index request'
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error UserPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'GET show' do
    before { get :show, id: user.id }

    context 'when authorized' do
      let(:authorized?) { true }
      let(:user) { create(:user, :admin) }

      it_behaves_like 'a successful request'
      it_behaves_like 'a show request'
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error UserPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'PATCH update' do
    before do
      patch :update,
            id: user.id,
            user: user_params
    end

    let(:user) { create(:user, :admin) }

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:user_params) { attributes_for(:user, :admin) }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(admin_user_path(user)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when the call is not successful' do
      let(:authorized?) { true }
      let(:user_params) { attributes_for(:user, :admin, name: nil) }

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit request'
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error UserPolicy }
      let(:user_params) { nil }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'POST create' do
    before do
      post :create,
           user: user_params
    end

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:user_params) { attributes_for(:user, :admin) }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(admin_user_path(assigns(:user))) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when the call is not successful' do
      let(:authorized?) { true }
      let(:user_params) { attributes_for(:user, :admin, name: nil) }

      it_behaves_like 'a successful request'
      it_behaves_like 'a new request'
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error UserPolicy }
      let(:user_params) { nil }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end
end
