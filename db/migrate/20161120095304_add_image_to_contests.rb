class AddImageToContests < ActiveRecord::Migration
  def change
    add_attachment :contests, :image
  end
end
