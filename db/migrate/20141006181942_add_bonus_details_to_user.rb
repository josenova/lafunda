class AddBonusDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :bonus_status, :integer
    add_column :users, :bonus_updated, :datetime
  end
end
