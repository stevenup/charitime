# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161229060100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "user_id"
    t.string   "receiver_name"
    t.string   "province"
    t.string   "city"
    t.string   "district"
    t.string   "detail_address"
    t.string   "mobile"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "default",        limit: 1
  end

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.string   "auth"
    t.string   "remarks"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "banners", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "is_custom",  default: "0"
    t.string   "custom_url"
  end

  create_table "carousels", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.string   "is_custom",    default: "0"
    t.string   "custom_url"
    t.string   "is_published", default: "0"
    t.string   "detail"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "carts", force: :cascade do |t|
    t.string   "openid"
    t.string   "product_id"
    t.integer  "product_price"
    t.string   "count"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "donation_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donation_records", force: :cascade do |t|
    t.string   "donation_record_id"
    t.string   "openid"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "donation_reviews", force: :cascade do |t|
    t.string   "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donation_states", force: :cascade do |t|
    t.string   "name",       default: "正在处理中"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "donations", force: :cascade do |t|
    t.string   "donation_record_id"
    t.string   "donation_id"
    t.string   "donation_name"
    t.string   "donation_category_id"
    t.string   "donation_description"
    t.integer  "gyb"
    t.string   "estimated_value"
    t.string   "donation_state_id"
    t.string   "donation_review_id"
    t.string   "logistics_company"
    t.string   "delivery_num"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "gyb_incomes", force: :cascade do |t|
    t.string   "user_id"
    t.string   "gyb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gyb_payments", force: :cascade do |t|
    t.string   "user_id"
    t.string   "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gybs", force: :cascade do |t|
    t.string   "title"
    t.integer  "gyb_type"
    t.string   "exchange_code"
    t.integer  "price"
    t.integer  "stock"
    t.datetime "expiration_time"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "logistics_companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.string   "order_detail_id"
    t.string   "order_id"
    t.string   "shelf_item_id"
    t.float    "price"
    t.integer  "count"
    t.string   "remark"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "receiver_name"
    t.string   "province"
    t.string   "city"
    t.string   "district"
    t.string   "detail_address"
    t.string   "mobile"
    t.integer  "express_price"
    t.string   "product_name"
    t.string   "delivery_id"
    t.string   "delivery_company"
    t.float    "gyb_discount"
    t.string   "out_refund_no"
    t.string   "thumb"
    t.string   "note"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "user_id"
    t.string   "order_id"
    t.integer  "order_status",                 null: false
    t.float    "total_price"
    t.string   "transaction_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "logistics_status", default: 0, null: false
    t.string   "out_trade_no"
  end

  create_table "products", force: :cascade do |t|
    t.string   "product_id"
    t.string   "project_id"
    t.string   "product_name"
    t.string   "category"
    t.string   "label"
    t.text     "product_detail"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "recommended",    limit: 1
    t.string   "thumb"
    t.string   "is_on_shelf",              default: "0"
  end

  create_table "products_projects", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "project_id"
  end

  create_table "project_types", force: :cascade do |t|
    t.string   "project_type_name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "project_id"
    t.string   "project_name"
    t.string   "category"
    t.string   "project_detail"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "recommended",    limit: 1
    t.string   "shelf_item_id"
    t.string   "banner"
    t.string   "main_pic"
    t.string   "thumb"
    t.string   "is_published",             default: "0"
    t.integer  "goal"
    t.string   "is_recommended",           default: "0"
  end

  create_table "projects_shelf_items", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "shelf_item_id"
  end

  create_table "shelf_items", force: :cascade do |t|
    t.string   "product_id"
    t.string   "project_id"
    t.string   "product_name"
    t.string   "category"
    t.string   "label"
    t.text     "product_detail"
    t.float    "price"
    t.float    "gyb_discount"
    t.integer  "stock"
    t.integer  "sales"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "is_on_shelf",    limit: 1
    t.string   "recommended",    limit: 1
    t.string   "thumb"
  end

  create_table "supports", force: :cascade do |t|
    t.string   "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "project_id"
    t.string   "support_type"
    t.float    "money"
    t.string   "status",          default: "0"
    t.string   "order_detail_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "openid"
    t.string   "nickname"
    t.string   "mobile"
    t.integer  "sex",            limit: 2
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "headimgurl"
    t.string   "unionid"
    t.string   "groupid"
    t.string   "remark"
    t.string   "language"
    t.integer  "subscribe",      limit: 2
    t.string   "subscribe_time"
    t.string   "address"
    t.integer  "gyb",                      default: 0
    t.string   "other"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "tagid_list"
  end

end
