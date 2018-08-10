class RemoveRentableFromBuyHouses < ActiveRecord::Migration[5.2]
  def change
    remove_column :buy_houses, :rentable, :boolean
    remove_column :buy_houses, :buyable, :boolean
    remove_column :buy_houses, :stayable, :boolean
  end
end
