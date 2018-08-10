class RemoveHouseIdFromShops < ActiveRecord::Migration[5.2]
  def change
    remove_column :shops, :house_id, :integer
  end
end
