require 'rails_helper'

RSpec.describe Location, type: :model do
  subject { build(:location) }
  it { is_expected.to have_many :cycle_counts }
  it { is_expected.to have_many(:pallets).through(:cycle_counts) }
  it { is_expected.to belong_to :created_by }
  it { is_expected.to belong_to :updated_by }

  it { is_expected.to validate_presence_of :location_number }
  it { is_expected.to validate_presence_of :area_number }
  it { is_expected.to validate_presence_of :sequence_number }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_numericality_of :location_number }
  it { is_expected.to validate_numericality_of :area_number }
  it { is_expected.to validate_numericality_of :sequence_number }

  it do
    is_expected.to validate_uniqueness_of(:location_number)
      .scoped_to([:area_number, :sequence_number])
  end
end
