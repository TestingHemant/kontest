class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :contest, index: true
      t.string :uploaded_image
      t.string :uploaded_video
      t.string :caption
      t.string :mobile, :limit=>"15"
      t.string :email
      t.string :votes, :limit=>"20"
      t.string :shares, :limit=>"20"
      t.string :status, :limit=>"50"
      t.string :rejected_reason

      t.timestamps null: false
    end
    add_foreign_key :entries, :contests
  end
end
