class AddImageUrlsToBuyHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :buy_houses, :image_url1, :string
    add_column :buy_houses, :image_url2, :string
    add_column :buy_houses, :image_url3, :string
    add_column :buy_houses, :image_url4, :string
  end
end
