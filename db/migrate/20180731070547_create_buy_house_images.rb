class CreateBuyHouseImages < ActiveRecord::Migration[5.2]
  def change
    create_table :buy_house_images do |t|
      t.string :image
      t.string :caption
      t.integer :buy_house_id
      t.timestamps
    end
  end
end
