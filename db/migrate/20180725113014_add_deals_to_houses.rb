class AddDealsToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :stayable, :boolean
    add_column :houses, :rentable, :boolean
    add_column :houses, :buyable, :boolean
  end
end
