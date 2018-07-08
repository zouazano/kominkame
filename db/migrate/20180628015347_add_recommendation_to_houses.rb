# frozen_string_literal: true

class AddRecommendationToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :recommendation, :integer
  end
end
