# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_02_001633) do

  create_table "languages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.integer "users_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "provider_id", null: false
    t.json "texts", null: false
    t.string "default_lang", null: false
    t.string "kind", default: "group"
    t.integer "user_notifications_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider_id"], name: "index_notifications_on_provider_id"
  end

  create_table "providers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.integer "min_limit", null: false
    t.integer "user_notifications_count", default: 0
    t.integer "last_min_count", default: 0
    t.datetime "last_sync"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "notification_id", null: false
    t.bigint "provider_id", null: false
    t.text "content", null: false
    t.string "lang_code", null: false
    t.string "notification_type", null: false
    t.boolean "incorrect_lang", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notification_id"], name: "index_user_notifications_on_notification_id"
    t.index ["provider_id"], name: "index_user_notifications_on_provider_id"
    t.index ["user_id"], name: "index_user_notifications_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.string "phone"
    t.bigint "language_id", null: false
    t.integer "user_notifications_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_users_on_language_id"
  end

  add_foreign_key "notifications", "providers"
  add_foreign_key "user_notifications", "notifications"
  add_foreign_key "user_notifications", "providers"
  add_foreign_key "user_notifications", "users"
  add_foreign_key "users", "languages"
end
