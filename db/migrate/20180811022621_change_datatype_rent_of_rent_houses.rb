class ChangeDatatypeRentOfRentHouses < ActiveRecord::Migration[5.2]
  def change
  	change_column :rent_houses, :rent, :float
  end
end
