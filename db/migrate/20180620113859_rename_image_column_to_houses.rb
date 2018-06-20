class RenameImageColumnToHouses < ActiveRecord::Migration[5.2]
  def change
  	rename_column :houses, :image, :image1
  end
end
