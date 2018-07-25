class AddSourceToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :source, :string
  end
end
