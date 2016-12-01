class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :name
      t.string :email
      t.string :mobile,:limit=>15
      t.string :report_type
      t.text :issue_description

      t.timestamps null: false
    end
  end
end
