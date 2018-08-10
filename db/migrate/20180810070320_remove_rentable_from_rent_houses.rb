class RemoveRentableFromRentHouses < ActiveRecord::Migration[5.2]
  def change
    remove_column :rent_houses, :rentable, :boolean
    remove_column :rent_houses, :buyable, :boolean
    remove_column :rent_houses, :stayable, :boolean
  end
end
