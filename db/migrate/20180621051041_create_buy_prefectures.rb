class CreateBuyPrefectures < ActiveRecord::Migration[5.2]
  def change
    create_table :buy_prefectures do |t|
      t.string :name
      t.integer :buy_count

      t.timestamps
    end
  end
end
