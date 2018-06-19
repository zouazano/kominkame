class CreateHeaders < ActiveRecord::Migration[5.2]
  def change
    create_table :headers do |t|
      t.string :image

      t.timestamps
    end
  end
end
