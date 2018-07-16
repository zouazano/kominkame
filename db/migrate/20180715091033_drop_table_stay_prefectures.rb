class DropTableStayPrefectures < ActiveRecord::Migration[5.2]
  def change
  	drop_table :stay_prefectures
  end
end
