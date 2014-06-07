class ChangeDataTypesForUsers < ActiveRecord::Migration
  change_column :users, :cellphone,  :string
  change_column :users, :identification,  :string
end
