class DropTableHeaders < ActiveRecord::Migration[5.2]
  def change
  	drop_table :headers
  end
end
