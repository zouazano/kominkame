# This migration comes from ebisu (originally 20180121080846)
class CreateEbisuTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :ebisu_tweets do |t|
      t.integer :paragraph_id
      t.string :content

      t.timestamps
    end
  end
end
