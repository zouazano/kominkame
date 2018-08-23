# This migration comes from ebisu (originally 20180121062735)
class CreateEbisuTags < ActiveRecord::Migration[5.1]
  def change
    create_table :ebisu_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
