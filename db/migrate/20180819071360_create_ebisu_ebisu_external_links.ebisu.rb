# This migration comes from ebisu (originally 20180520013309)
class CreateEbisuEbisuExternalLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :ebisu_ebisu_external_links do |t|
      t.integer :paragraph_id
      t.string :content
      t.string :url

      t.timestamps
    end
  end
end
