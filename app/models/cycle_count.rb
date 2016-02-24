class CycleCount < ActiveRecord::Base
  belongs_to :location
  belongs_to :created_by, class_name: 'User', foreign_key: :creator_id
  belongs_to :updated_by, class_name: 'User', foreign_key: :updater_id

  validates :location_id, :requested_date, presence: true
  validates :location_id, numericality: true
  validates :location_id, uniqueness: { scope: :requested_date }
end
