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

ActiveRecord::Schema.define(version: 20171117061809) do

  create_table "awesome_events_events", force: :cascade, comment: "イベント" do |t|
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

  create_table "awesome_events_tickets", force: :cascade, comment: "チケット" do |t|
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

  create_table "awesome_events_users", force: :cascade, comment: "ログインユーザ" do |t|
    t.string "provider", comment: "プロバイダ名"
    t.string "uid", comment: "ブロバイダ別ユーザ識別子"
    t.string "nickname", comment: "TwitterID"
    t.string "image_url", comment: "Twitterアイコン画像URL"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "baukis_addresses", force: :cascade, comment: "住所" do |t|
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
    t.index ["postal_code"], name: "baukis_addresses_postal_code"
    t.index ["prefecture", "city"], name: "baukis_addresses_prefecture_city"
    t.index ["type", "baukis_customer_id"], name: "baukis_addresses_type_customer_id", unique: true
    t.index ["type", "city"], name: "baukis_addresses_type_city"
    t.index ["type", "prefecture", "city"], name: "baukis_addresses_type_prefecture_city"
  end

  create_table "baukis_administrators", force: :cascade, comment: "管理者" do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "email_for_index", null: false, comment: "索引用メールアドレス"
    t.string "hashed_password", comment: "パスワード"
    t.boolean "suspended", default: false, null: false, comment: "停止フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_for_index"], name: "baukis_administrators_email", unique: true
  end

  create_table "baukis_allowed_sources", force: :cascade, comment: "許可IPアドレス" do |t|
    t.string "namespace", null: false, comment: "名前空間"
    t.integer "octet1", null: false, comment: "第１オクテット"
    t.integer "octet2", null: false, comment: "第２オクテット"
    t.integer "octet3", null: false, comment: "第３オクテット"
    t.integer "octet4", null: false, comment: "第４オクテット"
    t.boolean "wildcard", default: false, null: false, comment: "ワイルドカード"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["namespace", "octet1", "octet2", "octet3", "octet4"], name: "baukis_allowed_sources_on_namespace_and_octets", unique: true
  end

  create_table "baukis_customers", force: :cascade, comment: "顧客" do |t|
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
    t.index ["gender", "family_name_kana", "given_name_kana"], name: "baukis_customers_on_gender_and_furigana"
    t.index ["given_name_kana"], name: "baukis_customers_name_kana"
  end

  create_table "baukis_entries", force: :cascade, comment: "申し込み" do |t|
    t.bigint "program_id", null: false
    t.bigint "customer_id", null: false
    t.boolean "approved", default: false, null: false, comment: "承認済みフラグ"
    t.boolean "canceled", default: false, null: false, comment: "取り消しフラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "baukis_entries_customer_id"
    t.index ["customer_id"], name: "index_baukis_entries_on_customer_id"
    t.index ["program_id", "customer_id"], name: "baukis_entries_program_id_customer_id", unique: true
    t.index ["program_id"], name: "index_baukis_entries_on_program_id"
  end

  create_table "baukis_hash_locks", force: :cascade, comment: "排他制御" do |t|
    t.string "table", null: false, comment: "テーブル"
    t.string "column", null: false, comment: "カラム"
    t.string "key", null: false, comment: "キー"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "baukis_message_tag_links", force: :cascade, comment: "メッセージタグリンク" do |t|
    t.bigint "message_id", null: false, comment: "メッセージへの外部キー"
    t.bigint "tag_id", null: false, comment: "タグへの外部キー"
    t.index ["message_id", "tag_id"], name: "baukis_message_tag_links_message_id_tag_id", unique: true
    t.index ["message_id"], name: "index_baukis_message_tag_links_on_message_id"
    t.index ["tag_id"], name: "index_baukis_message_tag_links_on_tag_id"
  end

  create_table "baukis_messages", force: :cascade, comment: "問い合わせ" do |t|
    t.bigint "customer_id", null: false, comment: "顧客への外部キー"
    t.bigint "staff_member_id", comment: "職員への外部キー"
    t.integer "root_id", comment: "Messageへの外部キー"
    t.integer "parent_id", comment: "Messageへの外部キー"
    t.string "type", null: false, comment: "継承カラム"
    t.string "status", default: "new", null: false, comment: "状態（職員向け）"
    t.string "subject", null: false, comment: "件名"
    t.text "body", comment: "本文"
    t.text "remarks", comment: "備考（職員向け）"
    t.boolean "discarded", default: false, null: false, comment: "顧客側の削除フラグ"
    t.boolean "deleted", default: false, null: false, comment: "職員側の削除フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "deleted", "created_at"], name: "baukis_messages_customer_id_deleted_created_at"
    t.index ["customer_id", "deleted", "status", "created_at"], name: "baukis_messages_custoemr_id_deleted_status_created_at"
    t.index ["customer_id", "discarded", "created_at"], name: "baukis_messages_customer_id_discarded_created_at"
    t.index ["customer_id"], name: "baukis_messages_customer_id"
    t.index ["customer_id"], name: "index_baukis_messages_on_customer_id"
    t.index ["root_id", "deleted", "created_at"], name: "baukis_messages_root_id_deleted_created_at"
    t.index ["staff_member_id"], name: "baukis_messages_staff_member_id"
    t.index ["staff_member_id"], name: "index_baukis_messages_on_staff_member_id"
    t.index ["type", "customer_id"], name: "baukis_messages_type_customer_id"
    t.index ["type", "staff_member_id"], name: "baukis_messages_type_staff_member_id"
  end

  create_table "baukis_phones", force: :cascade, comment: "電話番号" do |t|
    t.bigint "baukis_customer_id", null: false, comment: "顧客への外部キー"
    t.bigint "baukis_address_id", comment: "住所への外部キー"
    t.string "number", null: false, comment: "電話番号"
    t.string "number_for_index", null: false, comment: "索引用電話番号"
    t.boolean "primary", default: false, null: false, comment: "優先フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_four_digits", comment: "電話番号下４桁"
    t.index ["baukis_address_id"], name: "baukis_phones_address_id"
    t.index ["baukis_address_id"], name: "index_baukis_phones_on_baukis_address_id"
    t.index ["baukis_customer_id"], name: "baukis_phones_customer_id"
    t.index ["baukis_customer_id"], name: "index_baukis_phones_on_baukis_customer_id"
    t.index ["last_four_digits"], name: "baukis_phones_last_four_digits"
    t.index ["number_for_index"], name: "baukis_phones_number_for_index"
  end

  create_table "baukis_programs", force: :cascade, comment: "プログラム" do |t|
    t.bigint "registrant_id", null: false, comment: "登録職員（外部キー）"
    t.string "title", null: false, comment: "タイトル"
    t.text "description", comment: "説明"
    t.datetime "application_start_time", null: false, comment: "申し込み開始日時"
    t.datetime "application_end_time", null: false, comment: "申し込み終了日時"
    t.integer "min_number_of_participants", comment: "最小参加者数"
    t.integer "max_number_of_participants", comment: "最大参加者数"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_start_time"], name: "baukis_programs_application_start_time"
    t.index ["registrant_id"], name: "baukis_programs_registrant_id"
    t.index ["registrant_id"], name: "index_baukis_programs_on_registrant_id"
  end

  create_table "baukis_staff_events", force: :cascade, comment: "イベント" do |t|
    t.bigint "baukis_staff_member_id", null: false, comment: "職員レコードへの外部キー"
    t.string "event_type", null: false, comment: "イベントタイプ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["baukis_staff_member_id", "created_at"], name: "baukis_staff_events_member_id_created_at"
    t.index ["baukis_staff_member_id"], name: "index_baukis_staff_events_on_baukis_staff_member_id"
    t.index ["created_at"], name: "baukis_staff_events_created_at"
  end

  create_table "baukis_staff_members", force: :cascade, comment: "職員" do |t|
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

  create_table "baukis_tags", force: :cascade, comment: "タグ" do |t|
    t.string "value", null: false, comment: "値"
    t.index ["value"], name: "index_baukis_tags_on_value", unique: true
  end

  create_table "messages", force: :cascade, comment: "ジョブメッセージ" do |t|
    t.text "body", comment: "本文"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfect_rails_accounts", force: :cascade, comment: "口座" do |t|
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

  create_table "perfect_rails_user2s", force: :cascade, comment: "ユーザ２" do |t|
    t.string "name", comment: "名前"
    t.string "prefecture", comment: "都道府県"
    t.string "city", comment: "市町村"
    t.string "house_number", comment: "番地"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfect_rails_users", force: :cascade, comment: "ユーザ" do |t|
    t.string "name", comment: "名前"
    t.string "prefecture", comment: "都道府県"
    t.string "city", comment: "市町村"
    t.string "house_number", comment: "番地"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rails_tutorial_sample_microposts", force: :cascade, comment: "マイクロポスト" do |t|
    t.text "content", comment: "内容"
    t.bigint "rails_tutorial_sample_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture", comment: "画像"
    t.index ["rails_tutorial_sample_user_id", "created_at"], name: "index_rails_tutorial_sample_micropost_on_user_id_created_at"
    t.index ["rails_tutorial_sample_user_id"], name: "index_rails_tutorial_sample_micropost_on_user_id"
  end

  create_table "rails_tutorial_sample_relationships", force: :cascade, comment: "関係" do |t|
    t.integer "follower_id", comment: "フォロー"
    t.integer "followed_id", comment: "フォロワー"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_rails_tutorial_sample_relationships_on_followed"
    t.index ["follower_id", "followed_id"], name: "index_rails_tutorial_sample_relationships_on_follow_followed", unique: true
    t.index ["follower_id"], name: "index_rails_tutorial_sample_relationships_on_follower"
  end

  create_table "rails_tutorial_sample_users", force: :cascade, comment: "ユーザ" do |t|
    t.string "name", comment: "名前"
    t.string "email", comment: "メールアドレス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false, comment: "管理者フラグ"
    t.string "activation_digest", comment: "認証ダイジェスト"
    t.boolean "activated", default: false, comment: "認証フラグ"
    t.datetime "activated_at", comment: "認証日"
    t.string "reset_digest", comment: "リセットダイジェスト"
    t.datetime "reset_sent_at", comment: "リセット送信日"
    t.index ["email"], name: "index_rails_tutorial_sample_users_on_email", unique: true
  end

  create_table "rails_tutorial_toy_microposts", force: :cascade, comment: "マイクロポスト" do |t|
    t.text "content", comment: "内容"
    t.integer "user_id", comment: "ユーザID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rails_tutorial_toy_users", force: :cascade, comment: "ユーザー" do |t|
    t.string "name", comment: "名前"
    t.string "email", comment: "メールアドレス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_modeling_purchase_order_lines", force: :cascade, comment: "発注明細" do |t|
    t.integer "line_number", comment: "明細番号"
    t.decimal "quantity_amount", precision: 10, comment: "数量"
    t.string "quantity_unit", comment: "単位"
    t.decimal "unit_price_amount", precision: 10, comment: "発注単価"
    t.string "unit_price_currency", comment: "通貨"
    t.decimal "price_amount", precision: 10, comment: "発注金額"
    t.string "price_currency", comment: "通貨"
    t.bigint "sales_modeling_purchase_orders_id", comment: "発注"
    t.bigint "sales_modeling_type3_sku_id", comment: "ストックキーピングユニット"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sales_modeling_purchase_orders_id"], name: "index_sales_modeling_purchase_order_line_id"
    t.index ["sales_modeling_type3_sku_id"], name: "index_sales_modeling_purchase_order_line_on_sku_id"
  end

  create_table "sales_modeling_purchase_orders", force: :cascade, comment: "発注" do |t|
    t.datetime "order_date", comment: "発注日"
    t.datetime "scheduled_arrival_date", comment: "入荷予定日"
    t.decimal "amount", precision: 10, comment: "金額"
    t.string "currency", comment: "通貨"
    t.bigint "sales_modeling_purchase_supplier_id", comment: "仕入先"
    t.bigint "order_type_category_id", comment: "発注区分"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_type_category_id"], name: "index_sales_modeling_purchase_order_category_id"
    t.index ["sales_modeling_purchase_supplier_id"], name: "index_sales_modeling_purchase_order_supplier_id"
  end

  create_table "sales_modeling_purchase_stock_lines", force: :cascade, comment: "入庫明細" do |t|
    t.integer "line_number", comment: "行番号"
    t.decimal "quantity_amount", precision: 10, comment: "数量"
    t.string "quantity_unit", comment: "単位"
    t.decimal "unit_price_amount", precision: 10, comment: "発注単価"
    t.string "unit_price_currency", comment: "通貨"
    t.decimal "price_amount", precision: 10, comment: "発注金額"
    t.string "price_currency", comment: "通貨"
    t.bigint "sales_modeling_purchase_stocks_id", comment: "入庫"
    t.bigint "sales_modeling_type3_sku_id", comment: "ストックキーピングユニット"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sales_modeling_purchase_stocks_id"], name: "index_sales_modeling_purchase_stock_line_id"
    t.index ["sales_modeling_type3_sku_id"], name: "index_sales_modeling_purchase_stock_line_on_sku_id"
  end

  create_table "sales_modeling_purchase_stocks", force: :cascade, comment: "入庫" do |t|
    t.datetime "arrival_date", comment: "入庫日付"
    t.datetime "acceptance_date", comment: "検収日付"
    t.bigint "sales_modeling_purchase_order_id", comment: "発注"
    t.bigint "sales_modeling_purchase_supplier_id", comment: "仕入先"
    t.bigint "stock_type_category_id", comment: "入庫区分"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sales_modeling_purchase_order_id"], name: "index_sales_modeling_purchase_stock_order_id"
    t.index ["sales_modeling_purchase_supplier_id"], name: "index_sales_modeling_purchase_stock_supplier_id"
    t.index ["stock_type_category_id"], name: "index_sales_modeling_purchase_stock_category_id"
  end

  create_table "sales_modeling_purchase_suppliers", force: :cascade, comment: "仕入先" do |t|
    t.string "code", comment: "コード"
    t.string "name", comment: "名称"
    t.string "prefecture", comment: "都道府県"
    t.string "city", comment: "市町村"
    t.string "house_number", comment: "番地"
    t.string "telephone_number", comment: "電話番号"
    t.bigint "supplier_type_category_id", comment: "仕入先区分"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_type_category_id"], name: "index_sales_modeling_purchase_supplier_category_id"
  end

  create_table "sales_modeling_purchase_warehouses", force: :cascade, comment: "倉庫" do |t|
    t.string "code", comment: "コード"
    t.string "name", comment: "名前"
    t.bigint "sales_modeling_purchase_order_id", comment: "発注"
    t.bigint "sales_modeling_purchase_stock_id", comment: "入庫"
    t.bigint "warehouse_type_category_id", comment: "倉庫区分"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sales_modeling_purchase_order_id"], name: "index_sales_modeling_purchase_warehouses_order_id"
    t.index ["sales_modeling_purchase_stock_id"], name: "index_sales_modeling_purchase_warehouses_stock_id"
    t.index ["warehouse_type_category_id"], name: "index_sales_modeling_purchase_warehouse_category_id"
  end

  create_table "sales_modeling_sales_customers", force: :cascade, comment: "顧客" do |t|
    t.string "code", comment: "コード"
    t.string "name", comment: "名称"
    t.string "prefecture", comment: "都道府県"
    t.string "city", comment: "市町村"
    t.string "house_number", comment: "番地"
    t.string "telephone_number", comment: "電話番号"
    t.bigint "customer_type_category_id", comment: "顧客区分"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_type_category_id"], name: "index_sales_modeling_salse_customer_category_id"
  end

  create_table "sales_modeling_sales_estimates", force: :cascade, comment: "見積" do |t|
    t.bigint "sales_estimate_id", comment: "見積"
    t.bigint "sales_order_id", comment: "注文"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sales_estimate_id"], name: "index_sales_modeling_sales_estimates_on_sales_estimate_id"
    t.index ["sales_order_id"], name: "index_sales_modeling_sales_estimates_on_sales_order_id"
  end

  create_table "sales_modeling_sales_sales", force: :cascade, comment: "売上" do |t|
    t.string "type", comment: "STIカラム"
    t.datetime "date", comment: "売上日"
    t.decimal "amount", precision: 10, comment: "金額"
    t.string "currency", comment: "通貨"
    t.bigint "sales_modeling_sales_customer_id", comment: "顧客"
    t.bigint "sales_type_category_id", comment: "売上区分"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sales_modeling_sales_customer_id"], name: "index_sales_modeling_sales_on_customer_id"
    t.index ["sales_type_category_id"], name: "index_sales_modeling_sales_sales_category_id"
  end

  create_table "sales_modeling_sales_sales_lines", force: :cascade, comment: "売上明細" do |t|
    t.integer "line_number", comment: "明細番号"
    t.decimal "quantity_amount", precision: 10, comment: "数量"
    t.string "quantity_unit", comment: "単位"
    t.decimal "unit_sales_price_amount", precision: 10, comment: "販売単価"
    t.string "unit_sales_price_currency", comment: "販売単価通貨"
    t.decimal "sales_price_amount", precision: 10, comment: "金額"
    t.string "sales_price_currency", comment: "通貨"
    t.bigint "sales_modeling_sales_sales_id", comment: "売上"
    t.bigint "sales_estimate_id", comment: "売上見積"
    t.bigint "sales_order_id", comment: "売上注文"
    t.bigint "sales_modeling_type3_sku_id", comment: "ストックキーピングユニット"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sales_estimate_id"], name: "index_sales_modeling_sales_on_sales_estimate_id"
    t.index ["sales_modeling_sales_sales_id"], name: "index_sales_modeling_sales_on_sales_id"
    t.index ["sales_modeling_type3_sku_id"], name: "index_sales_modeling_type3_on_sku_id"
    t.index ["sales_order_id"], name: "index_sales_modeling_sales_on_sales_order_id"
  end

  create_table "sales_modeling_type1_colors", force: :cascade, comment: "カラー" do |t|
    t.string "code", comment: "コード"
    t.string "name", comment: "名前"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_modeling_type1_product_categories", force: :cascade, comment: "商品区分" do |t|
    t.string "code", comment: "コード"
    t.string "name", comment: "名前"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_modeling_type1_products", force: :cascade, comment: "商品" do |t|
    t.string "code", comment: "商品コード"
    t.string "name", comment: "商品名"
    t.bigint "sales_modeling_type1_size_id"
    t.bigint "sales_modeling_type1_color_id"
    t.bigint "sales_modeling_type1_product_category_id"
    t.decimal "unit_purchase_price_amount", precision: 10, comment: "仕入単価"
    t.string "unit_purchase_price_currency", comment: "仕入単価通貨"
    t.decimal "unit_sales_price_amount", precision: 10, comment: "販売単価"
    t.string "unit_sales_price_currency", comment: "販売単価通貨"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sales_modeling_type1_color_id"], name: "index_sales_modeling_type1_on_color_id"
    t.index ["sales_modeling_type1_product_category_id"], name: "index_sales_modeling_type1_on_product_category_id"
    t.index ["sales_modeling_type1_size_id"], name: "index_sales_modeling_type1_on_size_id"
  end

  create_table "sales_modeling_type1_sizes", force: :cascade do |t|
    t.string "code", comment: "コード"
    t.string "name", comment: "名前"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_modeling_type2_categories", force: :cascade, comment: "分類" do |t|
    t.string "code", comment: "コード"
    t.string "name", comment: "分類名"
    t.bigint "sales_modeling_type2_category_class_id"
    t.bigint "parent_category_id", comment: "親カテゴリ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_category_id"], name: "index_sales_modeling_type2_categories_on_parent_category_id"
    t.index ["sales_modeling_type2_category_class_id"], name: "index_sales_modeling_type2_on_category_class_id"
  end

  create_table "sales_modeling_type2_category_classes", force: :cascade, comment: "分類種別" do |t|
    t.string "code", comment: "コード"
    t.string "name", comment: "分類種別名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_modeling_type2_products", force: :cascade, comment: "商品" do |t|
    t.string "code", comment: "商品コード"
    t.string "name", comment: "商品名"
    t.bigint "size_category_id", comment: "サイズ"
    t.bigint "color_category_id", comment: "色"
    t.bigint "product_type_category_id", comment: "製品区分"
    t.decimal "unit_purchase_price_amount", precision: 10, comment: "仕入単価"
    t.string "unit_purchase_price_currency", comment: "仕入単価通貨"
    t.decimal "unit_sales_price_amount", precision: 10, comment: "販売単価"
    t.string "unit_sales_price_currency", comment: "販売単価通貨"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["color_category_id"], name: "index_color_category_id"
    t.index ["product_type_category_id"], name: "index_product_type_category_id"
    t.index ["size_category_id"], name: "index_size_category_id"
  end

  create_table "sales_modeling_type3_categories", force: :cascade, comment: "分類" do |t|
    t.string "code", comment: "コード"
    t.string "name", comment: "分類名"
    t.string "symbol", comment: "シンボル"
    t.bigint "sales_modeling_type3_category_class_id"
    t.bigint "parent_category_id", comment: "親カテゴリ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_category_id"], name: "index_sales_modeling_type3_categories_on_parent_category_id"
    t.index ["sales_modeling_type3_category_class_id"], name: "index_sales_modeling_type3_on_category_class_id"
  end

  create_table "sales_modeling_type3_category_classes", force: :cascade, comment: "分類種別" do |t|
    t.string "code", comment: "コード"
    t.string "name", comment: "分類種別名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_modeling_type3_products", force: :cascade, comment: "商品" do |t|
    t.string "code", comment: "商品コード"
    t.string "name", comment: "商品名"
    t.bigint "product_type_category_id", comment: "製品区分"
    t.bigint "brand_category_id", comment: "ブランド"
    t.bigint "season_category_id", comment: "シーズン"
    t.bigint "year_category_id", comment: "年度"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_category_id"], name: "index_type3_brand_category_id"
    t.index ["product_type_category_id"], name: "index_type3_product_type_category_id"
    t.index ["season_category_id"], name: "index_type3_season_category_id"
    t.index ["year_category_id"], name: "index_type3_year_category_id"
  end

  create_table "sales_modeling_type3_skus", force: :cascade, comment: "ストックキーピングユニット" do |t|
    t.string "code", comment: "SKUコード"
    t.decimal "unit_purchase_price_amount", precision: 10, comment: "仕入単価"
    t.string "unit_purchase_price_currency", comment: "仕入単価通貨"
    t.decimal "unit_sales_price_amount", precision: 10, comment: "販売単価"
    t.string "unit_sales_price_currency", comment: "販売単価通貨"
    t.bigint "sales_modeling_type3_product_id", comment: "商品"
    t.bigint "size_category_id", comment: "サイズ"
    t.bigint "color_category_id", comment: "色"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["color_category_id"], name: "index_type3_color_category_id"
    t.index ["sales_modeling_type3_product_id"], name: "index_sales_modeling_type3_on_product_id"
    t.index ["size_category_id"], name: "index_type3_size_category_id"
  end

  create_table "todo_tasks", force: :cascade, comment: "タスク" do |t|
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
  add_foreign_key "rails_tutorial_sample_microposts", "rails_tutorial_sample_users"
  add_foreign_key "sales_modeling_purchase_order_lines", "sales_modeling_purchase_orders", column: "sales_modeling_purchase_orders_id"
  add_foreign_key "sales_modeling_purchase_order_lines", "sales_modeling_type3_skus"
  add_foreign_key "sales_modeling_purchase_orders", "sales_modeling_purchase_suppliers"
  add_foreign_key "sales_modeling_purchase_stock_lines", "sales_modeling_purchase_stocks", column: "sales_modeling_purchase_stocks_id"
  add_foreign_key "sales_modeling_purchase_stock_lines", "sales_modeling_type3_skus"
  add_foreign_key "sales_modeling_purchase_stocks", "sales_modeling_purchase_orders"
  add_foreign_key "sales_modeling_purchase_stocks", "sales_modeling_purchase_suppliers"
  add_foreign_key "sales_modeling_purchase_warehouses", "sales_modeling_purchase_orders"
  add_foreign_key "sales_modeling_purchase_warehouses", "sales_modeling_purchase_stocks"
  add_foreign_key "sales_modeling_sales_sales", "sales_modeling_sales_customers"
  add_foreign_key "sales_modeling_sales_sales_lines", "sales_modeling_sales_sales", column: "sales_modeling_sales_sales_id"
  add_foreign_key "sales_modeling_sales_sales_lines", "sales_modeling_type3_skus"
  add_foreign_key "sales_modeling_type1_products", "sales_modeling_type1_colors"
  add_foreign_key "sales_modeling_type1_products", "sales_modeling_type1_product_categories"
  add_foreign_key "sales_modeling_type1_products", "sales_modeling_type1_sizes"
  add_foreign_key "sales_modeling_type2_categories", "sales_modeling_type2_category_classes"
  add_foreign_key "sales_modeling_type3_categories", "sales_modeling_type3_category_classes"
  add_foreign_key "sales_modeling_type3_skus", "sales_modeling_type3_products"
end
