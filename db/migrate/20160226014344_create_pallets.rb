class CreatePallets < ActiveRecord::Migration
  def change
    create_table :pallets do |t|
      t.references :cycle_count, index: true, foreign_key: true
      t.string :pallet_number, null: false
      t.string :check_state, default: 'Pending'
      t.string :check_location
      t.string :check_result

      t.timestamps null: false
      t.userstamps null: false
    end
  end
end
