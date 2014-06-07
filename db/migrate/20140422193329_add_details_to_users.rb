class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :surname, :string
    add_column :users, :identification, :integer
    add_column :users, :birthday, :date
    add_column :users, :cellphone, :integer
    add_column :users, :pin, :integer
  end
end
