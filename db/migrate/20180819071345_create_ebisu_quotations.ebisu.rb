# This migration comes from ebisu (originally 20180121065600)
class CreateEbisuQuotations < ActiveRecord::Migration[5.1]
  def change
    create_table :ebisu_quotations do |t|
      t.integer :paragraph_id
      t.string :content

      t.timestamps
    end
  end
end
