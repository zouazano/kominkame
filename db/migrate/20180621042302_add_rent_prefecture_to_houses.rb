class AddRentPrefectureToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :rent_prefecture_id, :integer
    add_column :houses, :buy_prefecture_id, :integer
    add_column :houses, :stay_prefecture_id, :integer
  end
end
