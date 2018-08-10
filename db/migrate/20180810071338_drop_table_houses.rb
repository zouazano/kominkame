class DropTableHouses < ActiveRecord::Migration[5.2]
  def change
  	drop_table :houses
  end
end
