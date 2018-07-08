# frozen_string_literal: true

class AddDetailsToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :price, :integer
    add_column :houses, :image, :string
    add_column :houses, :type, :integer
  end
end
