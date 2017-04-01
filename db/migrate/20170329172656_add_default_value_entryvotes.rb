class AddDefaultValueEntryvotes < ActiveRecord::Migration
  def change
	change_column :entries, :entryvotes, :integer, :default => 0
  end
end
