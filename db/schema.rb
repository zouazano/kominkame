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

ActiveRecord::Schema.define(version: 2018_07_29_085117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "buy_houses", force: :cascade do |t|
    t.string "name"
    t.text "strong_point"
    t.integer "prefecture_id"
    t.integer "price"
    t.string "zip_code"
    t.string "address"
    t.string "access"
    t.string "hours"
    t.integer "age"
    t.string "madori"
    t.float "land_area"
    t.float "house_area"
    t.string "built_time"
    t.text "notes"
    t.boolean "stayable"
    t.boolean "rentable"
    t.boolean "buyable"
    t.integer "recommendation"
    t.integer "shop_id"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "house_images", force: :cascade do |t|
    t.string "image"
    t.string "caption"
    t.integer "house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rent_house_id"
    t.integer "buy_house_id"
    t.integer "stay_house_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.text "strong_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "prefecture_id"
    t.string "zip_code"
    t.string "address"
    t.string "access"
    t.string "hours"
    t.integer "shop_id"
    t.integer "price"
    t.integer "age"
    t.string "madori"
    t.float "land_area"
    t.float "house_area"
    t.string "built_time"
    t.integer "recommendation"
    t.string "source"
    t.boolean "stayable"
    t.boolean "rentable"
    t.boolean "buyable"
  end

  create_table "inquiries", force: :cascade do |t|
    t.integer "house_id"
    t.integer "user_id"
    t.integer "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "address"
    t.string "email"
    t.string "phonenumber"
    t.integer "demand"
    t.text "message"
    t.integer "rent_house_id"
    t.integer "buy_house_id"
    t.integer "stay_house_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.integer "rent_cout"
    t.integer "buy_cout"
    t.integer "stay_cout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rent_houses", force: :cascade do |t|
    t.string "name"
    t.text "strong_point"
    t.integer "prefecture_id"
    t.integer "rent"
    t.integer "maintenance_fee"
    t.integer "deposit"
    t.integer "gratuity_fee"
    t.string "zip_code"
    t.string "address"
    t.string "access"
    t.string "hours"
    t.integer "age"
    t.string "madori"
    t.float "land_area"
    t.float "house_area"
    t.string "built_time"
    t.boolean "stayable"
    t.boolean "rentable"
    t.boolean "buyable"
    t.integer "recommendation"
    t.integer "shop_id"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "owner"
    t.integer "house_id"
    t.integer "inquiry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stay_houses", force: :cascade do |t|
    t.string "name"
    t.text "strong_point"
    t.integer "prefecture_id"
    t.integer "accommodation_expenses"
    t.string "zip_code"
    t.string "address"
    t.string "access"
    t.string "hours"
    t.integer "age"
    t.string "madori"
    t.float "land_area"
    t.float "house_area"
    t.string "built_time"
    t.text "notes"
    t.boolean "stayable"
    t.boolean "rentable"
    t.boolean "buyable"
    t.integer "recommendation"
    t.integer "shop_id"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
