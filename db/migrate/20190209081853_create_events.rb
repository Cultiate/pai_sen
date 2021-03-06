class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :coach_id
      t.string :title
      t.datetime :start
      t.datetime :end
      t.string :color
      t.boolean :allday
      t.string :timenumber
      t.date :date
      t.timestamps
    end
  end
end
