class AddimageToUpdates < ActiveRecord::Migration
  def change
  	add_attachment :updates, :image
  end
end
