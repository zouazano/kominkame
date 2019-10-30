class ChangeColumnToInquiry < ActiveRecord::Migration[5.2]

  def up
    change_column :inquiries, :buy_house_id, :integer, null: false
    remove_column :inquiries, :user_id
    remove_column :inquiries, :shop_id
  end

  # 変更前の状態
  def down
    change_column :inquiries, :buy_house_id, :integer, null: true
    add_column :inquiries, :user_id, :integer
    add_column :inquiries, :shop_id, :integer
  end

end
