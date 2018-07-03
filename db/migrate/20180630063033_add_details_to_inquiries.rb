class AddDetailsToInquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :inquiries, :name, :string
    add_column :inquiries, :address, :string
    add_column :inquiries, :email, :string
    add_column :inquiries, :phonenumber, :string
    add_column :inquiries, :demand, :integer
    add_column :inquiries, :message, :text
  end
end
