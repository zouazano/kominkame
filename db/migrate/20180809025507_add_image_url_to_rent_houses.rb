class AddImageUrlToRentHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :rent_houses, :image_url, :string
  end
end
