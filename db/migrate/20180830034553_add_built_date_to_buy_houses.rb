class AddBuiltDateToBuyHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :buy_houses, :built_date, :datetime
  end
end
