require 'rails_helper'

RSpec.describe CreateUser, type: :interactor do
  describe '.call' do
    let(:name) { Faker::Name.name }
    let(:email) { Faker::Internet.email }

    let(:context) do
      CreateUser.call(
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
            .to eq(I18n.t('users.create.success'))
        end
      end
    end
  end
end
