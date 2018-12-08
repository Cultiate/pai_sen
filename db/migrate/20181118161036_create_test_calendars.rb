class CreateTestCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :test_calendars do |t|
      t.datetime :start_time

      t.timestamps
    end
  end
end
