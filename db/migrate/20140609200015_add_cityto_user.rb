class AddCitytoUser < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
  end
end
