class AddCountsToRentPrefectures < ActiveRecord::Migration[5.2]
  def change
    add_column :rent_prefectures, :rent_count, :integer
  end
end
