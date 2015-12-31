require 'rails_helper'

RSpec.describe Site::HomeController, type: :controller do
  describe 'GET index' do
    context 'when signed in' do
      before do
        sign_in(build_stubbed(:user))

        get :index
      end

      it_behaves_like 'a successful request'
      it_behaves_like 'an index request'
    end
    context 'when not signed in' do
      before { get :index }

      it_behaves_like 'a redirect'
    end
  end
end
