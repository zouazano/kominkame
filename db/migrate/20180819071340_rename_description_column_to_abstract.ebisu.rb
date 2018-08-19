# This migration comes from ebisu (originally 20171113042621)
class RenameDescriptionColumnToAbstract < ActiveRecord::Migration[5.1]
  def change
  	rename_column :ebisu_articles, :description, :abstract
  end
end
