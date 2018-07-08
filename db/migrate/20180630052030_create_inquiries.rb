# frozen_string_literal: true

class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.integer :house_id
      t.integer :user_id
      t.integer :shop_id

      t.timestamps
    end
  end
end
