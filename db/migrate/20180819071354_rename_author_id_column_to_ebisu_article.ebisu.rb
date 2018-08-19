# This migration comes from ebisu (originally 20180209113012)
class RenameAuthorIdColumnToEbisuArticle < ActiveRecord::Migration[5.1]
  def change
    rename_column :ebisu_articles, :author_id, :user_id
  end
end
