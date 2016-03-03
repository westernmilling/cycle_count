class Location < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User', foreign_key: :creator_id
  belongs_to :updated_by, class_name: 'User', foreign_key: :updater_id
  has_many :cycle_counts
  has_many :pallets, through: :cycle_counts

  validates :location_number, :area_number, :sequence_number, :description,
            presence: true
  validates :location_number,
            uniqueness: { scope: [:area_number, :sequence_number] }
  validates :location_number, :area_number, :sequence_number, numericality: true
end
