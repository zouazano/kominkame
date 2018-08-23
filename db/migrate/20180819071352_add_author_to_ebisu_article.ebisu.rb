# This migration comes from ebisu (originally 20180204011041)
class AddAuthorToEbisuArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :ebisu_articles, :author_id, :integer
  end
end
