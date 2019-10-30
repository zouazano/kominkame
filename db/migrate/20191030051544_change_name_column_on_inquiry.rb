class ChangeNameColumnOnInquiry < ActiveRecord::Migration[5.2]
  def up
    change_column :inquiries, :name, :string, null: false
    change_column :inquiries, :email, :string, null: false
  end

  # 変更前の状態
  def down
    change_column :inquiries, :name, :string, null: true
    change_column :inquiries, :email, :string, null: true
  end
end
