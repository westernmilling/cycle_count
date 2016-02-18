class CreateCycleCounts < ActiveRecord::Migration
  def change
    create_table :cycle_counts do |t|
      t.references :location, index: true, foreign_key: true
      t.datetime :requested_date, null: false

      t.timestamps null: false
      t.userstamps null: false
    end
  end
end
