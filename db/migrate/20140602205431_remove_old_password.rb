class RemoveOldPassword < ActiveRecord::Migration
  def change
    remove_column :users, :encrypted_password
    remove_column :users, :unlock_token
    remove_column :users, :unconfirmed_email
  end
end
