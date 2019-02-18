class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :event_id
      t.integer :user_id
      t.date :date
      t.string :timenumber
      t.timestamps
    end
  end
end
