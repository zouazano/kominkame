class CreateBuyHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :buy_houses do |t|
      t.string :name
      t.text :strong_point
      t.integer :prefecture_id
      t.integer :price    
      t.string :zip_code
      t.string :address
      t.string :access
      t.string :hours
      t.integer :age
      t.string :madori
      t.float :land_area
      t.float :house_area
      t.string :built_time
      t.text :notes
      t.boolean :stayable
      t.boolean :rentable
      t.boolean :buyable
      t.integer :recommendation
      t.integer :shop_id
      t.string :source
      t.timestamps
    end
  end
end
