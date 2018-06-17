class CreatePrefectures < ActiveRecord::Migration[5.2]
  def change
    create_table :prefectures do |t|
      t.string :name
      t.integer :rent_cout
      t.integer :buy_cout
      t.integer :stay_cout

      t.timestamps
    end
  end
end
