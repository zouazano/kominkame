# frozen_string_literal: true

class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :name
      t.text :strong_point
      t.timestamps null: false
      t.integer :prefecture_id
      t.string :zip_code
      t.string :address
      t.string :access
      t.string :hours
      t.integer :shop_id
    end
  end
end
