class ChangeDatatypeEntryvotes < ActiveRecord::Migration
  def change
  	change_column :entries, :entryvotes, :integer
  end
end
