require 'rails_helper'

RSpec.describe MenuHelper, type: :helper do
  describe '#menu' do
    subject { helper.menu }

    it { is_expected.to have_selector 'ul' }
  end
end
