class AddDefaultToBonusStatus < ActiveRecord::Migration
  def change
    change_column :users, :bonus_status, :integer, :default => 0
  end
end
