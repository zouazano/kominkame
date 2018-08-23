# This migration comes from ebisu (originally 20180204025722)
class AddParentCategoryToEbisuCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :ebisu_categories, :parent_id, :integer
  end
end
