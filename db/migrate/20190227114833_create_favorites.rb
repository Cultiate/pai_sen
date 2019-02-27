class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :coach, foreign_key: true

      t.timestamps
      t.index [:user_id, :coach_id], unique: true
    end
  end
end
