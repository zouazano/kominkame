class CreateStayPrefectures < ActiveRecord::Migration[5.2]
  def change
    create_table :stay_prefectures do |t|
      t.string :name
      t.integer :stay_count

      t.timestamps
    end
  end
end
