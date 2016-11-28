class AddImageToEntries < ActiveRecord::Migration
  def change
    add_attachment :entries, :image
  end
end
