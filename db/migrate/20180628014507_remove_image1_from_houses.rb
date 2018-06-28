class RemoveImage1FromHouses < ActiveRecord::Migration[5.2]
  def change
    remove_column :houses, :image1, :string
    remove_column :houses, :image2, :string
    remove_column :houses, :image3, :string
    remove_column :houses, :image4, :string
    remove_column :houses, :image5, :string
    remove_column :houses, :image6, :string
  end
end
