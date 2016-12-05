class AddUserToContests < ActiveRecord::Migration
  def change
    add_reference :contests, :user, index: true
    add_foreign_key :contests, :users
  end
end
