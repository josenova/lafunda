class AddDetailsToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :author, :string
    add_column :entries, :message, :string
    add_column :entries, :employee, :boolean
  end
end
