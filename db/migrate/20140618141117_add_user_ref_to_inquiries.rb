class AddUserRefToInquiries < ActiveRecord::Migration
  def change
    add_reference :inquiries, :user, index: true
    add_column :inquiries, :subject, :string
    add_column :inquiries, :message, :string
    add_column :inquiries, :status, :boolean, :default => true
  end
end
