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

ActiveRecord::Schema.define(version: 20170801071547) do

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
    t.integer "awesome_events_user_id"
    t.integer "awesome_events_event_id"
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

  create_table "baukis_addresses", force: :cascade do |t|
    t.integer "baukis_customer_id", null: false
    t.string "type", null: false
    t.string "postal_code", null: false
    t.string "prefecture", null: false
    t.string "city", null: false
    t.string "address1", null: false
    t.string "address2", null: false
    t.string "company_name", default: "", null: false
    t.string "division_name", default: "", null: false
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

  create_table "baukis_administrators", force: :cascade do |t|
    t.string "email", null: false
    t.string "email_for_index", null: false
    t.string "hashed_password"
    t.boolean "suspended", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_for_index"], name: "baukis_administrators_email", unique: true
  end

  create_table "baukis_allowed_sources", force: :cascade do |t|
    t.string "namespace", null: false
    t.integer "octet1", null: false
    t.integer "octet2", null: false
    t.integer "octet3", null: false
    t.integer "octet4", null: false
    t.boolean "wildcard", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["namespace", "octet1", "octet2", "octet3", "octet4"], name: "baukis_allowed_sources_on_namespace_and_octets", unique: true
  end

  create_table "baukis_customers", force: :cascade do |t|
    t.string "email", null: false
    t.string "email_for_index", null: false
    t.string "family_name", null: false
    t.string "given_name", null: false
    t.string "family_name_kana", null: false
    t.string "given_name_kana", null: false
    t.string "gender"
    t.date "birthday"
    t.string "hashed_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "birth_year"
    t.integer "birth_month"
    t.integer "birth_mday"
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

  create_table "baukis_entries", force: :cascade do |t|
    t.integer "program_id", null: false
    t.integer "customer_id", null: false
    t.boolean "approved", default: false, null: false
    t.boolean "canceled", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "baukis_entries_customer_id"
    t.index ["customer_id"], name: "index_baukis_entries_on_customer_id"
    t.index ["program_id", "customer_id"], name: "baukis_entries_program_id_customer_id", unique: true
    t.index ["program_id"], name: "index_baukis_entries_on_program_id"
  end

  create_table "baukis_hash_locks", force: :cascade do |t|
    t.string "table", null: false
    t.string "column", null: false
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "baukis_message_tag_links", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "tag_id", null: false
    t.index ["message_id", "tag_id"], name: "baukis_message_tag_links_message_id_tag_id", unique: true
    t.index ["message_id"], name: "index_baukis_message_tag_links_on_message_id"
    t.index ["tag_id"], name: "index_baukis_message_tag_links_on_tag_id"
  end

  create_table "baukis_messages", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "staff_member_id"
    t.integer "root_id"
    t.integer "parent_id"
    t.string "type", null: false
    t.string "status", default: "new", null: false
    t.string "subject", null: false
    t.text "body"
    t.text "remarks"
    t.boolean "discarded", default: false, null: false
    t.boolean "deleted", default: false, null: false
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

  create_table "baukis_phones", force: :cascade do |t|
    t.integer "baukis_customer_id", null: false
    t.integer "baukis_address_id"
    t.string "number", null: false
    t.string "number_for_index", null: false
    t.boolean "primary", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_four_digits"
    t.index ["baukis_address_id"], name: "baukis_phones_address_id"
    t.index ["baukis_address_id"], name: "index_baukis_phones_on_baukis_address_id"
    t.index ["baukis_customer_id"], name: "baukis_phones_customer_id"
    t.index ["baukis_customer_id"], name: "index_baukis_phones_on_baukis_customer_id"
    t.index ["last_four_digits"], name: "baukis_phones_last_four_digits"
    t.index ["number_for_index"], name: "baukis_phones_number_for_index"
  end

  create_table "baukis_programs", force: :cascade do |t|
    t.integer "registrant_id", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "application_start_time", null: false
    t.datetime "application_end_time", null: false
    t.integer "min_number_of_participants"
    t.integer "max_number_of_participants"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_start_time"], name: "baukis_programs_application_start_time"
    t.index ["registrant_id"], name: "baukis_programs_registrant_id"
    t.index ["registrant_id"], name: "index_baukis_programs_on_registrant_id"
  end

  create_table "baukis_staff_events", force: :cascade do |t|
    t.integer "baukis_staff_member_id", null: false
    t.string "event_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["baukis_staff_member_id", "created_at"], name: "baukis_staff_events_member_id_created_at"
    t.index ["baukis_staff_member_id"], name: "index_baukis_staff_events_on_baukis_staff_member_id"
    t.index ["created_at"], name: "baukis_staff_events_created_at"
  end

  create_table "baukis_staff_members", force: :cascade do |t|
    t.string "email", null: false
    t.string "email_for_index", null: false
    t.string "family_name", null: false
    t.string "given_name", null: false
    t.string "family_name_kana", null: false
    t.string "given_name_kana", null: false
    t.string "hashed_password"
    t.date "start_date", null: false
    t.date "end_date"
    t.boolean "suspended", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_for_index"], name: "baukis_staff_members_email", unique: true
    t.index ["family_name_kana", "given_name_kana"], name: "baukis_staff_members_name_kana"
  end

  create_table "baukis_tags", force: :cascade do |t|
    t.string "value", null: false
    t.index ["value"], name: "index_baukis_tags_on_value", unique: true
  end

  create_table "perfect_rails_accounts", force: :cascade do |t|
    t.integer "amount"
    t.string "currency"
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

  create_table "rails_tutorial_toy_microposts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rails_tutorial_toy_users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "todo_tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "content", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
