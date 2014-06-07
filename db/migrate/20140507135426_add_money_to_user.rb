class AddMoneyToUser < ActiveRecord::Migration
  def change
    add_money :users, :balance
  end
end
