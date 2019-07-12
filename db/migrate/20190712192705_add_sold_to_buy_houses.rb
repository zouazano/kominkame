class AddSoldToBuyHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :buy_houses, :sold, :boolean, default: false, null: false
  end
end
