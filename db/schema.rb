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

ActiveRecord::Schema.define(version: 2021_01_25_002734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.text "image"
    t.string "name"
    t.string "url"
    t.string "info"
    t.string "category"
    t.boolean "custom", default: false
    t.integer "created_by", null: false
    t.integer "released_by"
    t.datetime "released_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by"], name: "index_brands_on_created_by"
    t.index ["custom"], name: "index_brands_on_custom"
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "brand_id"
    t.bigint "user_id", null: false
    t.decimal "amount"
    t.integer "frequency"
    t.string "unit"
    t.date "first_bill"
    t.boolean "enabled", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_subscriptions_on_brand_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name"
    t.string "nickname"
    t.string "given_name"
    t.string "family_name"
    t.string "locale"
    t.string "email"
    t.text "image"
    t.boolean "enabled", default: true
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "brands", "users", column: "created_by"
  add_foreign_key "brands", "users", column: "released_by"
  add_foreign_key "subscriptions", "brands"
  add_foreign_key "subscriptions", "users"
end
