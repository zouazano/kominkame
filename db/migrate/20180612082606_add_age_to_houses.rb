class AddAgeToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :age, :integer
  end
end
