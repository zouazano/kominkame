class RemoveStayPrefectureIdFromHouses < ActiveRecord::Migration[5.2]
  def change
    remove_column :houses, :stay_prefecture_id, :integer
  end
end
