class AddHeadingToContests < ActiveRecord::Migration
  def change
    add_column :contests, :conheading, :string
  end
end
