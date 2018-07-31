class CreateStayHouseImages < ActiveRecord::Migration[5.2]
  def change
    create_table :stay_house_images do |t|
      t.string :image
      t.string :caption
      t.integer :stay_house_id

      t.timestamps
    end
  end
end
