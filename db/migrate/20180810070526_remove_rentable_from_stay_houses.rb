class RemoveRentableFromStayHouses < ActiveRecord::Migration[5.2]
  def change
    remove_column :stay_houses, :rentable, :boolean
    remove_column :stay_houses, :buyable, :boolean
    remove_column :stay_houses, :stayable, :boolean
  end
end
