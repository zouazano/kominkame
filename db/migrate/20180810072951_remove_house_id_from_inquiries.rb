class RemoveHouseIdFromInquiries < ActiveRecord::Migration[5.2]
  def change
    remove_column :inquiries, :house_id, :integer
  end
end
