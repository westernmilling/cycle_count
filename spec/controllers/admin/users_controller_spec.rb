require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  before do
    sign_in(user)
  end

  let(:user) { build_stubbed(:user) }

  describe 'GET edit' do
    before { get :edit, id: user.id }

    let(:user) { create(:user) }

    it_behaves_like 'a successful request'
    it_behaves_like 'an edit request'
  end

  describe 'GET index' do
    before do
      get :index
    end

    it_behaves_like 'a successful request'
    it_behaves_like 'an index request'
  end

  describe 'PATCH update' do
    before do
      allow(UpdateUser).to receive(:call) { context }

      patch :update,
            id: user.id,
            entry: {
              name: Faker::Name.name,
              is_active: [0, 1].sample
            }
    end

    let(:user) { create(:user) }
    let(:context) { double(user: user, message: '', success?: success?) }
    let(:success?) { fail 'success? not set' }

    context 'when the call is successful' do
      let(:success?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(admin_users_path) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when the call is not successful' do
      let(:success?) { false }

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit request'
      it { is_expected.to set_flash[:alert] }
    end
  end

  describe 'POST create' do
    before do
      allow(CreateUser).to receive(:call) { context }

      post :create,
           entry: {
             email: Faker::Internet.email,
             name: Faker::Name.name,
             is_active: [0, 1].sample
           }
    end
    let(:context) { double(user: user, message: '', success?: success?) }
    let(:success?) { fail 'success? not set' }

    context 'when the call is successful' do
      let(:success?) { true }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(admin_users_path) }
      it { is_expected.to set_flash[:notice] }
    end
    context 'when the call is not successful' do
      let(:success?) { false }

      it_behaves_like 'a successful request'
      it_behaves_like 'a new request'
      it { is_expected.to set_flash[:alert] }
    end
  end
end
