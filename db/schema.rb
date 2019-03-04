# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_27_202602) do

  create_table "coaches", force: :cascade do |t|
    t.string "name"
    t.string "kana"
    t.string "email"
    t.datetime "birthday"
    t.boolean "status"
    t.string "company"
    t.string "business"
    t.string "occupation"
    t.text "greeting"
    t.integer "coaching_fee"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false, null: false
    t.datetime "activated_at"
    t.string "coach_image"
    t.string "provider"
    t.string "uid"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_coaches_on_email"
    t.index ["name"], name: "index_coaches_on_name"
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coach_id"
    t.string "title"
    t.datetime "start"
    t.datetime "end"
    t.string "color"
    t.boolean "allday"
    t.string "timenumber"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coach_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_id"], name: "index_favorites_on_coach_id"
    t.index ["user_id", "coach_id"], name: "index_favorites_on_user_id_and_coach_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coach_id"
    t.integer "room_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_id"], name: "index_messages_on_coach_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.date "date"
    t.string "timenumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coach_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_id"], name: "index_rooms_on_coach_id"
    t.index ["user_id", "coach_id"], name: "index_rooms_on_user_id_and_coach_id", unique: true
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "kana"
    t.string "email"
    t.string "birthday"
    t.string "university"
    t.string "department"
    t.string "graduate_year"
    t.text "greeting"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false, null: false
    t.datetime "activated_at"
    t.string "user_image"
    t.string "provider"
    t.string "uid"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["name"], name: "index_users_on_name"
  end

end
