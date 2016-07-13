class AddNotesToPallet < ActiveRecord::Migration
  def change
    add_column :pallets, :notes, :string
  end
end
