# This migration comes from ebisu (originally 20180211023449)
class AddTypeToEbisuCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :ebisu_categories, :type, :string
  end
end
