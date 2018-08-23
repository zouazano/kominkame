# This migration comes from ebisu (originally 20180115102558)
class CreateEbisuFigures < ActiveRecord::Migration[5.1]
  def change
    create_table :ebisu_figures do |t|
      t.integer :paragraph_id
      t.string :content_uid

      t.timestamps
    end
  end
end
