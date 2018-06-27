class CreateHouseImages < ActiveRecord::Migration[5.2]
  def change
    create_table :house_images do |t|
      t.string :image
      t.string :caption
      t.integer :house_id

      t.timestamps
    end
  end
end
