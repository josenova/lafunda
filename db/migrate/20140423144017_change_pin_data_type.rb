class ChangePinDataType < ActiveRecord::Migration
  change_column :users, :pin,  :string
end
