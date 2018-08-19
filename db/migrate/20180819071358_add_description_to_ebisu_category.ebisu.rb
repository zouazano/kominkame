# This migration comes from ebisu (originally 20180219051148)
class AddDescriptionToEbisuCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :ebisu_categories, :description, :text
  end
end
