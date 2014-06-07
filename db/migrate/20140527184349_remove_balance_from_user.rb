class RemoveBalanceFromUser < ActiveRecord::Migration
  def change
    remove_money :users, :balance
  end
end
