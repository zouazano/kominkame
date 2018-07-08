# frozen_string_literal: true

class AddMadoriToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :madori, :string
    add_column :houses, :land_area, :float
    add_column :houses, :house_area, :float
    add_column :houses, :built_time, :string
  end
end
