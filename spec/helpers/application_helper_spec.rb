require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#error_messages' do
    subject { helper.error_messages(object) }

    context 'when there are no object errors' do
      let(:object) { double(:object, errors: []) }

      it { is_expected.to be_nil }
    end

    context 'when there are errors' do
      let(:object) do
        double(:object,
               errors: double(full_messages: [Faker::Lorem.sentence]))
      end

      it { is_expected.to_not be_nil }
      it { is_expected.to have_css 'div.alert-danger' }
      it { is_expected.to have_css 'div ul li', count: 1 }
    end
  end
end
