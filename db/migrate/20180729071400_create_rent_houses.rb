class CreateRentHouses < ActiveRecord::Migration[5.2]
  def change
      create_table :rent_houses do |t|
      t.string :name
      t.text :strong_point
      t.integer :prefecture_id
      t.integer :rent
      t.integer :maintenance_fee
      t.integer :deposit
      t.integer :gratuity_fee      
      t.string :zip_code
      t.string :address
      t.string :access
      t.string :hours
      t.integer :age
      t.string :madori
      t.float :land_area
      t.float :house_area
      t.string :built_time
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
