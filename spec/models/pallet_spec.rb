require 'rails_helper'

RSpec.describe Pallet, type: :model do
  subject { build(:pallet) }
  it { is_expected.to belong_to :cycle_count }
  it { is_expected.to belong_to :created_by }
  it { is_expected.to belong_to :updated_by }
  it { is_expected.to have_one(:location).through(:cycle_count) }

  it { is_expected.to validate_presence_of :cycle_count_id }
  it { is_expected.to validate_presence_of :pallet_number }
  it { is_expected.to validate_numericality_of :cycle_count_id }

  it do
    is_expected.to validate_uniqueness_of(:cycle_count_id)
      .scoped_to(:pallet_number)
  end
end
