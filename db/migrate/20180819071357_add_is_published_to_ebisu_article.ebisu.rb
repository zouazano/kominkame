# This migration comes from ebisu (originally 20180219024310)
class AddIsPublishedToEbisuArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :ebisu_articles, :is_published, :boolean, default: false, null: false
  end
end
