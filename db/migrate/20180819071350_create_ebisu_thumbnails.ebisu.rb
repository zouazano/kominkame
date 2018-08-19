# This migration comes from ebisu (originally 20180128062139)
class CreateEbisuThumbnails < ActiveRecord::Migration[5.1]
  def change
    create_table :ebisu_thumbnails do |t|
      t.string :signature
      t.string :uid

      t.timestamps
    end
  end
end
