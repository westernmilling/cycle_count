require 'rails_helper'

RSpec.describe UpdateUser, type: :interactor do
  describe '.call' do
    let(:user) { create(:user) }
    let(:name) { Faker::Name.name }
    let(:email) { Faker::Internet.email }

    let(:context) do
      UpdateUser.call(
        id: user.id,
        name: name,
        email: email,
        is_active: 1)
    end

    context 'when the user is valid' do
      describe Interactor::Context do
        subject { context }

        its(:success?) { is_expected.to be true }
        its(:message) do
          is_expected
            .to eq(I18n.t('users.update.success'))
        end
      end
    end
  end
end
