# This migration comes from ebisu (originally 20171105061420)
class CreateEbisuBodies < ActiveRecord::Migration[5.1]
  def change
    create_table :ebisu_bodies do |t|
      t.integer :paragraph_id
      t.text :content

      t.timestamps
    end
  end
end
