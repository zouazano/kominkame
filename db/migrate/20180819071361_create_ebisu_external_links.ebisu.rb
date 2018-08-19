# This migration comes from ebisu (originally 20180520013534)
class CreateEbisuExternalLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :ebisu_external_links do |t|
      t.integer :paragraph_id
      t.string :content
      t.string :url

      t.timestamps
    end
  end
end
