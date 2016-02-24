require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  before do
    sign_in(user)

    allow(controller).to receive(:authorize) { authorized? }
    allow(controller).to receive(:pundit_policy_authorized?) { authorized? }
    allow(User).to receive(:find) { user }
  end
  let(:user) { build_stubbed(:user) }

  describe 'GET edit' do
    before { get :edit, id: user.id }

    context 'when authorized' do
      let(:authorized?) { true }

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit request'
      it { expect(send(:user)).to be_kind_of(User) }
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error UserPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'GET index' do
    before do
      allow(controller).to receive(:users) { users }
      get :index
    end
    let(:users) { build_stubbed_list(:user, 2) }

    context 'when authorized' do
      let(:authorized?) { true }

      it_behaves_like 'a successful request'
      it_behaves_like 'an index request'
      it { expect(send(:users)).to be_kind_of(Array) }
      it { expect(send(:users)[0]).to be_kind_of(User) }
      it { expect(send(:users).size).to eq(users.size) }
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

      it_behaves_like 'a successful request'
      it_behaves_like 'a show request'
      it { expect(send(:user)).to be_kind_of(User) }
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error UserPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'PATCH update' do
    before do
      allow(user).to receive(:update_attributes) { update? }
      patch :update, id: user.id, user: attributes_for(:user)
    end
    let(:update?) { fail 'update? not set' }

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:update?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to admin_user_path(user) }
      it do
        is_expected
          .to set_flash[:notice]
          .to I18n.t('admin.users.update.success')
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
          .to(I18n.t('admin.users.update.failure'))
      end
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error UserPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end

  describe 'POST create' do
    before do
      allow(user).to receive(:save) { create? }
      allow(User).to receive(:new) { user }
      post :create, user: nil
    end
    let(:user) { build_stubbed(:user) }
    let(:create?) { fail 'update? not set' }

    context 'when the call is successful' do
      let(:authorized?) { true }
      let(:create?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(admin_user_path(assigns(:user))) }
      it do
        is_expected
          .to set_flash[:notice]
          .to I18n.t('admin.users.create.success')
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
          .to(I18n.t('admin.users.create.failure'))
      end
    end

    context 'when not authorized' do
      let(:authorized?) { raise_pundit_error UserPolicy }

      it_behaves_like 'an unauthorized access to a resource'
    end
  end
end
