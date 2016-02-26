class Pallet < ActiveRecord::Base
  belongs_to :cycle_count
  belongs_to :created_by, class_name: 'User', foreign_key: :creator_id
  belongs_to :updated_by, class_name: 'User', foreign_key: :updater_id
  has_one :location, through: :cycle_count

  validates :cycle_count_id, :pallet_number, presence: true
  validates :cycle_count_id, numericality: true
  validates :cycle_count_id, uniqueness: { scope: :pallet_number }
end
