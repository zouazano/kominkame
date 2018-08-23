# This migration comes from ebisu (originally 20170813171453)
class CreateEbisuParagraphs < ActiveRecord::Migration[5.1]
  def change
    create_table :ebisu_paragraphs do |t|
      t.integer :article_id
      t.integer :position
      t.string :type

      t.timestamps
    end
  end
end
