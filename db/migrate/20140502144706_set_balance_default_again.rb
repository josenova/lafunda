class SetBalanceDefaultAgain < ActiveRecord::Migration
  def change
    change_column :users, :balance, :decimal, :default => 0.00
  end
end
