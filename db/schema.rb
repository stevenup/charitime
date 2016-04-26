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

ActiveRecord::Schema.define(version: 20160426060518) do

  create_table "admins", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "password",   limit: 255
    t.string   "auth",       limit: 255
    t.string   "remarks",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "banners", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "donation_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "donation_records", force: :cascade do |t|
    t.string   "donation_record_id", limit: 255
    t.string   "openid",             limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "donation_reviews", force: :cascade do |t|
    t.string   "admin_id",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "donation_states", force: :cascade do |t|
    t.string   "name",       limit: 255, default: "正在处理中"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "donations", force: :cascade do |t|
    t.string   "donation_record_id",   limit: 255
    t.string   "donation_id",          limit: 255
    t.string   "donation_name",        limit: 255
    t.string   "donation_category_id", limit: 255
    t.string   "donation_description", limit: 255
    t.integer  "gyb",                  limit: 4
    t.string   "estimated_value",      limit: 255
    t.string   "donation_state_id",    limit: 255
    t.string   "donation_review_id",   limit: 255
    t.string   "logistics_company",    limit: 255
    t.string   "delivery_num",         limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "logistics_companies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string   "product_category_name", limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "product_labels", force: :cascade do |t|
    t.string   "product_label_name", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "product_id",          limit: 255
    t.string   "project_id",          limit: 255
    t.string   "product_name",        limit: 255
    t.string   "product_price",       limit: 255
    t.string   "product_category_id", limit: 255
    t.string   "product_label_id",    limit: 255
    t.string   "gyb_discount",        limit: 255
    t.string   "product_detail",      limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "recommended",         limit: 1
  end

  create_table "project_types", force: :cascade do |t|
    t.string   "project_type_name", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "project_id",      limit: 255
    t.string   "project_name",    limit: 255
    t.string   "project_type_id", limit: 255
    t.string   "project_detail",  limit: 255
    t.string   "openid",          limit: 255
    t.string   "support_id",      limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "recommended",     limit: 1
  end

  create_table "support_types", force: :cascade do |t|
    t.string   "support_type_name", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "supports", force: :cascade do |t|
    t.string   "openid",          limit: 255
    t.string   "support_type_id", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "openid",         limit: 255
    t.string   "nickname",       limit: 255
    t.string   "mobile",         limit: 255
    t.integer  "sex",            limit: 1
    t.string   "city",           limit: 255
    t.string   "province",       limit: 255
    t.string   "country",        limit: 255
    t.string   "headimgurl",     limit: 255
    t.string   "unionid",        limit: 255
    t.string   "groupid",        limit: 255
    t.string   "remark",         limit: 255
    t.string   "language",       limit: 255
    t.integer  "subscribe",      limit: 1
    t.string   "subscribe_time", limit: 255
    t.string   "address",        limit: 255
    t.integer  "gyb",            limit: 4
    t.string   "other",          limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
