class AddUserToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :user_id, :string
  end
end
