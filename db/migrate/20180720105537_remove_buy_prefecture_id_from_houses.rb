class RemoveBuyPrefectureIdFromHouses < ActiveRecord::Migration[5.2]
  def change
    remove_column :houses, :rent_prefecture_id, :integer
    remove_column :houses, :buy_prefecture_id, :integer
  end
end
