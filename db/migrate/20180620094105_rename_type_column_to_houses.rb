class RenameTypeColumnToHouses < ActiveRecord::Migration[5.2]
  def change
  	rename_column :houses, :type, :dealtype
  end
end
