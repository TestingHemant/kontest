class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :title
      t.string :contest_type
      t.string :banner
      t.text :description
      t.text :steps
      t.string :first_prize
      t.string :second_prize
      t.string :third_prize
      t.string :status
      t.string :suspension_reason
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
