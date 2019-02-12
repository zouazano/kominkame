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

ActiveRecord::Schema.define(version: 2019_02_12_004139) do

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

  create_table "buy_house_images", force: :cascade do |t|
    t.string "image"
    t.string "caption"
    t.integer "buy_house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "buy_house_image_uid"
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
    t.integer "recommendation"
    t.integer "shop_id"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url1"
    t.string "image_url2"
    t.string "image_url3"
    t.string "image_url4"
    t.datetime "built_date"
  end

  create_table "ebisu_article_tags", force: :cascade do |t|
    t.integer "article_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_articles", force: :cascade do |t|
    t.string "title"
    t.text "abstract"
    t.string "image"
    t.integer "category_id"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_uid"
    t.integer "impressions_count", default: 0
    t.integer "user_id"
    t.boolean "published", default: false, null: false
  end

  create_table "ebisu_bodies", force: :cascade do |t|
    t.integer "paragraph_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.string "type"
    t.text "description"
  end

  create_table "ebisu_ebisu_external_links", force: :cascade do |t|
    t.integer "paragraph_id"
    t.string "content"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_external_links", force: :cascade do |t|
    t.integer "paragraph_id"
    t.string "content"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_figures", force: :cascade do |t|
    t.integer "paragraph_id"
    t.string "content_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source"
    t.string "source_url"
  end

  create_table "ebisu_headlines", force: :cascade do |t|
    t.integer "paragraph_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_paragraphs", force: :cascade do |t|
    t.integer "article_id"
    t.integer "position"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_preformatted_bodies", force: :cascade do |t|
    t.integer "paragraph_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_quotations", force: :cascade do |t|
    t.integer "paragraph_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_subheadlines", force: :cascade do |t|
    t.integer "paragraph_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_thumbnails", force: :cascade do |t|
    t.string "signature"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_tweets", force: :cascade do |t|
    t.integer "paragraph_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebisu_youtubes", force: :cascade do |t|
    t.string "content"
    t.integer "paragraph_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "inquiries", force: :cascade do |t|
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

  create_table "rent_house_images", force: :cascade do |t|
    t.string "image"
    t.string "caption"
    t.integer "rent_house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rent_house_image_uid"
  end

  create_table "rent_houses", force: :cascade do |t|
    t.string "name"
    t.text "strong_point"
    t.integer "prefecture_id"
    t.float "rent"
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
    t.integer "recommendation"
    t.integer "shop_id"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "owner"
    t.integer "inquiry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stay_house_images", force: :cascade do |t|
    t.string "image"
    t.string "caption"
    t.integer "stay_house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stay_house_image_uid"
  end

  create_table "stay_houses", force: :cascade do |t|
    t.string "name"
    t.text "strong_point"
    t.integer "prefecture_id"
    t.float "accommodation_expenses"
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
    t.integer "recommendation"
    t.integer "shop_id"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
