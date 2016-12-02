class AddUserToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :user_id, :string
  end
end
