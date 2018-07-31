class AddHouseIdsToInquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :inquiries, :rent_house_id, :integer
    add_column :inquiries, :buy_house_id, :integer
    add_column :inquiries, :stay_house_id, :integer
  end
end
