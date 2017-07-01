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

ActiveRecord::Schema.define(version: 20170701020023) do

  create_table "awesome_events_events", force: :cascade do |t|
    t.integer "owner_id"
    t.string "name", null: false
    t.string "place", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_image"
  end

  create_table "awesome_events_tickets", force: :cascade do |t|
    t.bigint "awesome_events_user_id"
    t.bigint "awesome_events_event_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["awesome_events_event_id", "awesome_events_user_id"], name: "by_event_id_user_id", unique: true
    t.index ["awesome_events_event_id"], name: "index_awesome_events_tickets_on_awesome_events_event_id"
    t.index ["awesome_events_user_id", "awesome_events_event_id"], name: "by_user_id_event_id", unique: true
    t.index ["awesome_events_user_id"], name: "index_awesome_events_tickets_on_awesome_events_user_id"
  end

  create_table "awesome_events_users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "nickname"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfect_rails_bank_accounts", force: :cascade do |t|
    t.string "credit_card_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfect_rails_comments", force: :cascade do |t|
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfect_rails_credit_cards", force: :cascade do |t|
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfect_rails_rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfect_rails_schedules", force: :cascade do |t|
    t.integer "room_id"
    t.datetime "finished_at"
    t.datetime "started_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfect_rails_subscriptions", force: :cascade do |t|
    t.date "signed_up_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfect_rails_user2s", force: :cascade do |t|
    t.string "name"
    t.string "prefecture"
    t.string "city"
    t.string "house_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfect_rails_users", force: :cascade do |t|
    t.string "name"
    t.string "prefecture"
    t.string "city"
    t.string "house_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
