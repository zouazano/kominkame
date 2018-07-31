class AddHouseIdsToHouseImages < ActiveRecord::Migration[5.2]
  def change
    add_column :house_images, :rent_house_id, :integer
    add_column :house_images, :buy_house_id, :integer
    add_column :house_images, :stay_house_id, :integer
  end
end
