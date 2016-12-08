class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :entries, :votes, :entryvotes
  end
end
