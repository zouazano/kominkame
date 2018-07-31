class CreateRentHouseImages < ActiveRecord::Migration[5.2]
  def change
    create_table :rent_house_images do |t|
      t.string :image
      t.string :caption
      t.integer :rent_house_id
      t.timestamps
    end
  end
end
