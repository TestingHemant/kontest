class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :participant_name
      t.string :email
      t.text :display_text

      t.timestamps null: false
    end
  end
end
