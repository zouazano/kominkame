class CreateThumbs < ActiveRecord::Migration[5.2]
  def change
    create_table :thumbs do |t|
      t.string :signature
      t.string :uid

      t.timestamps
    end
  end
end
