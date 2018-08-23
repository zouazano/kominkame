# This migration comes from ebisu (originally 20180121084118)
class CreateEbisuYoutubes < ActiveRecord::Migration[5.1]
  def change
    create_table :ebisu_youtubes do |t|
      t.string :content
      t.integer :paragraph_id

      t.timestamps
    end
  end
end
