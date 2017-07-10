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

ActiveRecord::Schema.define(version: 20170710092934) do

  create_table "awesome_events_events", force: :cascade,  comment: "イベント" do |t|
    t.integer "owner_id", comment: "イベントを作成したユーザのID"
    t.string "name", null: false, comment: "イベントの名前"
    t.string "place", null: false, comment: "イベントの開催場所"
    t.datetime "start_time", null: false, comment: "イベント開始時間"
    t.datetime "end_time", null: false, comment: "イベント終了時間"
    t.text "content", null: false, comment: "イベントの詳細"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_image", comment: "画像用カラム"
  end

  create_table "awesome_events_tickets", force: :cascade,  comment: "チケット" do |t|
    t.bigint "awesome_events_user_id", comment: "ユーザID"
    t.bigint "awesome_events_event_id", comment: "イベントID"
    t.string "comment", comment: "コメント"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["awesome_events_event_id", "awesome_events_user_id"], name: "by_event_id_user_id", unique: true
    t.index ["awesome_events_event_id"], name: "index_awesome_events_tickets_on_awesome_events_event_id"
    t.index ["awesome_events_user_id", "awesome_events_event_id"], name: "by_user_id_event_id", unique: true
    t.index ["awesome_events_user_id"], name: "index_awesome_events_tickets_on_awesome_events_user_id"
  end

  create_table "awesome_events_users", force: :cascade,  comment: "ログインユーザ" do |t|
    t.string "provider", comment: "プロバイダ名"
    t.string "uid", comment: "ブロバイダ別ユーザ識別子"
    t.string "nickname", comment: "TwitterID"
    t.string "image_url", comment: "Twitterアイコン画像URL"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "baukis_addresses", force: :cascade,  comment: "住所" do |t|
    t.bigint "baukis_customer_id", null: false, comment: "顧客への外部キー"
    t.string "type", null: false, comment: "継承カラム"
    t.string "postal_code", null: false, comment: "郵便番号"
    t.string "prefecture", null: false, comment: "都道府県"
    t.string "city", null: false, comment: "市区町村"
    t.string "address1", null: false, comment: "町域、番地等"
    t.string "address2", null: false, comment: "建物名、部屋番号等"
    t.string "company_name", default: "", null: false, comment: "会社名"
    t.string "division_name", default: "", null: false, comment: "部署名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["baukis_customer_id"], name: "baukis_addresses_customer_id"
    t.index ["baukis_customer_id"], name: "index_baukis_addresses_on_baukis_customer_id"
    t.index ["city"], name: "baukis_addresses_city"
    t.index ["prefecture", "city"], name: "baukis_addresses_prefecture_city"
    t.index ["type", "baukis_customer_id"], name: "baukis_addresses_type_customer_id", unique: true
    t.index ["type", "city"], name: "baukis_addresses_type_city"
    t.index ["type", "prefecture", "city"], name: "baukis_addresses_type_prefecture_city"
  end

  create_table "baukis_administrators", force: :cascade,  comment: "管理者" do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "email_for_index", null: false, comment: "索引用メールアドレス"
    t.string "hashed_password", comment: "パスワード"
    t.boolean "suspended", default: false, null: false, comment: "停止フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_for_index"], name: "baukis_administrators_email", unique: true
  end

  create_table "baukis_customers", force: :cascade,  comment: "顧客" do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "email_for_index", null: false, comment: "索引用メールアドレス"
    t.string "family_name", null: false, comment: "姓"
    t.string "given_name", null: false, comment: "名"
    t.string "family_name_kana", null: false, comment: "姓（カナ）"
    t.string "given_name_kana", null: false, comment: "名（カナ）"
    t.string "gender", comment: "性別"
    t.date "birthday", comment: "誕生日"
    t.string "hashed_password", comment: "パスワード"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "birth_year", comment: "誕生年"
    t.integer "birth_month", comment: "誕生月"
    t.integer "birth_mday", comment: "誕生日"
    t.index ["birth_mday", "family_name_kana", "given_name_kana"], name: "baukis_customers_on_birth_mday_and_furigana"
    t.index ["birth_mday", "given_name_kana"], name: "baukis_customers_biarth_day_name_kana"
    t.index ["birth_month", "birth_mday"], name: "baukis_customers_birth_month_day"
    t.index ["birth_month", "family_name_kana", "given_name_kana"], name: "baukis_customers_on_birth_month_and_furigana"
    t.index ["birth_year", "birth_month", "birth_mday"], name: "baukis_customers_birth_year_month_day"
    t.index ["birth_year", "family_name_kana", "given_name_kana"], name: "baukis_customers_on_birth_year_and_furigana"
    t.index ["email_for_index"], name: "baukis_customers_email_for_index", unique: true
    t.index ["family_name_kana", "given_name_kana"], name: "baukis_customers_nanme_kana"
    t.index ["given_name_kana"], name: "baukis_customers_name_kana"
  end

  create_table "baukis_phones", force: :cascade,  comment: "電話番号" do |t|
    t.bigint "baukis_customer_id", null: false, comment: "顧客への外部キー"
    t.bigint "baukis_address_id", comment: "住所への外部キー"
    t.string "number", null: false, comment: "電話番号"
    t.string "number_for_index", null: false, comment: "索引用電話番号"
    t.boolean "primary", default: false, null: false, comment: "優先フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["baukis_address_id"], name: "baukis_phones_address_id"
    t.index ["baukis_address_id"], name: "index_baukis_phones_on_baukis_address_id"
    t.index ["baukis_customer_id"], name: "baukis_phones_customer_id"
    t.index ["baukis_customer_id"], name: "index_baukis_phones_on_baukis_customer_id"
    t.index ["number_for_index"], name: "baukis_phones_number_for_index"
  end

  create_table "baukis_staff_events", force: :cascade,  comment: "イベント" do |t|
    t.bigint "baukis_staff_member_id", null: false, comment: "職員レコードへの外部キー"
    t.string "event_type", null: false, comment: "イベントタイプ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["baukis_staff_member_id", "created_at"], name: "baukis_staff_events_member_id_created_at"
    t.index ["baukis_staff_member_id"], name: "index_baukis_staff_events_on_baukis_staff_member_id"
    t.index ["created_at"], name: "baukis_staff_events_created_at"
  end

  create_table "baukis_staff_members", force: :cascade,  comment: "職員" do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "email_for_index", null: false, comment: "索引用メールアドレス"
    t.string "family_name", null: false, comment: "姓"
    t.string "given_name", null: false, comment: "名"
    t.string "family_name_kana", null: false, comment: "姓（カナ）"
    t.string "given_name_kana", null: false, comment: "名（カナ）"
    t.string "hashed_password", comment: "パスワード"
    t.date "start_date", null: false, comment: "開始日"
    t.date "end_date", comment: "終了日"
    t.boolean "suspended", default: false, null: false, comment: "停止フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_for_index"], name: "baukis_staff_members_email", unique: true
    t.index ["family_name_kana", "given_name_kana"], name: "baukis_staff_members_name_kana"
  end

  create_table "perfect_rails_accounts", force: :cascade,  comment: "口座" do |t|
    t.integer "amount", comment: "金額"
    t.string "currency", comment: "通貨"
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

  create_table "perfect_rails_user2s", force: :cascade,  comment: "ユーザ２" do |t|
    t.string "name", comment: "名前"
    t.string "prefecture", comment: "都道府県"
    t.string "city", comment: "市町村"
    t.string "house_number", comment: "番地"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfect_rails_users", force: :cascade,  comment: "ユーザ" do |t|
    t.string "name", comment: "名前"
    t.string "prefecture", comment: "都道府県"
    t.string "city", comment: "市町村"
    t.string "house_number", comment: "番地"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "todo_tasks", force: :cascade,  comment: "タスク" do |t|
    t.string "name", null: false, comment: "名前"
    t.text "content", null: false, comment: "内容"
    t.integer "status", default: 0, null: false, comment: "ステータス 0:NOT_YET 1:DONE 2:PENDING"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "awesome_events_tickets", "awesome_events_events"
  add_foreign_key "awesome_events_tickets", "awesome_events_users"
  add_foreign_key "baukis_addresses", "baukis_customers"
  add_foreign_key "baukis_phones", "baukis_addresses"
  add_foreign_key "baukis_phones", "baukis_customers"
  add_foreign_key "baukis_staff_events", "baukis_staff_members"
end
