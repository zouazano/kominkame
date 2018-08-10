class DropTableHouseImages < ActiveRecord::Migration[5.2]
  def change
  	drop_table :house_images
  end
end
