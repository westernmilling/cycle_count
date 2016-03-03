require 'rails_helper'

RSpec.describe CycleCount, type: :model do
  subject { build(:cycle_count) }
  it { is_expected.to belong_to :location }
  it { is_expected.to belong_to :created_by }
  it { is_expected.to belong_to :updated_by }
  it { is_expected.to have_many :pallets }

  it { is_expected.to validate_presence_of :location_id }
  it { is_expected.to validate_presence_of :requested_date }
  it { is_expected.to validate_numericality_of :location_id }

  it do
    is_expected.to validate_uniqueness_of(:location_id)
      .scoped_to(:requested_date)
  end
end
