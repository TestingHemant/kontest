class AddKeywordToContests < ActiveRecord::Migration
  def change
    add_column :contests, :keywords, :text
  end
end
