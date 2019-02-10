class CreateCoaches < ActiveRecord::Migration[5.2]
  def change
    create_table :coaches do |t|
      t.string :name
      t.string :kana
      t.string :email
      t.datetime :birthday
      t.boolean :status
      t.string :company
      t.string :business
      t.string :occupation
      t.text :greeting
      t.integer :coaching_fee
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.boolean :activated
      t.datetime :activated_at
      t.string :user_image
      t.string :provider
      t.string :uid
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
