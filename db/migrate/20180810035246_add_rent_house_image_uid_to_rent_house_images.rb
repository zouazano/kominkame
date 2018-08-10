class AddRentHouseImageUidToRentHouseImages < ActiveRecord::Migration[5.2]
  def change
    add_column :rent_house_images, :rent_house_image_uid, :string
  end
end
