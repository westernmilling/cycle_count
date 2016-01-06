require 'rails_helper'

RSpec.describe UserEntry, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:name) }
  its(:persisted?) { is_expected.to be_falsey }

  describe 'unique?' do
    let(:entry) { UserEntry.new(attributes_for(:user)) }
    subject { entry }

    describe 'custom validators are invoked' do
      before do
        allow(entry).to receive(:unique?)
        entry.valid?
      end

      it { is_expected.to have_received(:unique?) }
    end

    context 'when the email exists' do
      before do
        allow(User)
          .to receive(:find_by)
          .with(email: entry.email)
          .and_return(double(:user))

        entry.valid?
      end

      its(:valid?) { is_expected.to be false }
      it 'should add an error to email' do
        expect(entry.errors.messages[:email]).to be_present
      end
    end

    context 'when the email does not exists' do
      before do
        allow(User)
          .to receive(:find_by)
          .with(email: entry.email)
          .and_return(nil)

        entry.valid?
      end

      its(:valid?) { is_expected.to be true }
      it 'should not add an error to email' do
        expect(entry.errors[:email]).to be_empty
      end
    end
  end
end
