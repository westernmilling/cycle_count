class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :location_number, null: false
      t.integer :area_number, null: false
      t.integer :sequence_number, null: false
      t.string :description, null: false

      t.timestamps null: false
      t.userstamps null: false
    end
  end
end
