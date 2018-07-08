# frozen_string_literal: true

class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :owner
      t.integer :house_id
      t.integer :inquiry_id

      t.timestamps
    end
  end
end
