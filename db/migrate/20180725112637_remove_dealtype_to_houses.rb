class RemoveDealtypeToHouses < ActiveRecord::Migration[5.2]
  def change
  	remove_column :houses, :dealtype, :integer
  end
end
