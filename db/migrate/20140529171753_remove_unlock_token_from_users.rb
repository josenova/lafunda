class RemoveUnlockTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :unlock_token
  end
end
