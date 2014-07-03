class ChangeTypeForLongerText < ActiveRecord::Migration
  def change
    change_column :inquiries, :message, :text
    change_column :entries, :message, :text
  end
end
