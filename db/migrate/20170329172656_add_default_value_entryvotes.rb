class AddDefaultValueEntryvotes < ActiveRecord::Migration
  def change
	change_column :entries, :entryvotes, :default => 0
  end
end
