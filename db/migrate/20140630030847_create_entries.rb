class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|

      t.timestamps
    end
    add_reference :entries, :inquiry, index: true
  end
end
