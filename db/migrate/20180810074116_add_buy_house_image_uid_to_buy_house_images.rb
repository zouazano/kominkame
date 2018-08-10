class AddBuyHouseImageUidToBuyHouseImages < ActiveRecord::Migration[5.2]
  def change
    add_column :buy_house_images, :buy_house_image, :string
  end
end
