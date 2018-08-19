# This migration comes from ebisu (originally 20180115104939)
class CreateEbisuCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :ebisu_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
