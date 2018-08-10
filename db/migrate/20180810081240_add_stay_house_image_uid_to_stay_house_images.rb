class AddStayHouseImageUidToStayHouseImages < ActiveRecord::Migration[5.2]
  def change
    add_column :stay_house_images, :stay_house_image_uid, :string
  end
end
