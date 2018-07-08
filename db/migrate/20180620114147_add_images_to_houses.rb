# frozen_string_literal: true

class AddImagesToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :image2, :string
    add_column :houses, :image3, :string
    add_column :houses, :image4, :string
    add_column :houses, :image5, :string
    add_column :houses, :image6, :string
  end
end
