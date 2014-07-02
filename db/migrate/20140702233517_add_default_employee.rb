class AddDefaultEmployee < ActiveRecord::Migration
  def change
    change_column :entries, :employee, :boolean, :default => false
  end
end
