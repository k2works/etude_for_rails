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

ActiveRecord::Schema.define(version: 20170619081450) do

  create_table "awesome_events_events", force: :cascade, comment: "イベント" do |t|
    t.integer "owner_id", comment: "イベントを作成したユーザのID"
    t.string "name", null: false, comment: "イベントの名前"
    t.string "place", null: false, comment: "イベントの開催場所"
    t.datetime "start_time", null: false, comment: "イベント開始時間"
    t.datetime "end_time", null: false, comment: "イベント終了時間"
    t.text "content", null: false, comment: "イベントの詳細"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "awesome_events_users", force: :cascade, comment: "ログインユーザ" do |t|
    t.string "provider", comment: "プロバイダ名"
    t.string "uid", comment: "ブロバイダ別ユーザ識別子"
    t.string "nickname", comment: "TwitterID"
    t.string "image_url", comment: "Twitterアイコン画像URL"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
