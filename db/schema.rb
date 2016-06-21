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

ActiveRecord::Schema.define(version: 20160621025332) do

  create_table "account_books", force: true do |t|
    t.integer  "user_id"
    t.string   "category"
    t.string   "item_type"
    t.integer  "item_id"
    t.string   "title"
    t.string   "remark",     limit: 1000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", force: true do |t|
    t.string   "name"
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

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, length: {"email"=>100}, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, length: {"reset_password_token"=>100}, using: :btree

  create_table "admins_roles", id: false, force: true do |t|
    t.integer "admin_id"
    t.integer "role_id"
  end

  add_index "admins_roles", ["admin_id", "role_id"], name: "index_admins_roles_on_admin_id_and_role_id", using: :btree

  create_table "areas", force: true do |t|
    t.string  "code"
    t.string  "name"
    t.string  "parent_code"
    t.integer "parent_id"
    t.integer "lft",                        null: false
    t.integer "rgt",                        null: false
    t.integer "depth",          default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.integer "level"
    t.integer "position"
    t.string  "pinyin"
  end

  create_table "banners", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "url",         limit: 500
    t.string   "image"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", force: true do |t|
    t.integer  "store_id"
    t.integer  "user_id"
    t.integer  "category"
    t.string   "name"
    t.integer  "position"
    t.integer  "count"
    t.string   "state"
    t.string   "logo"
    t.string   "desc"
    t.string   "phone"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "begin_at"
    t.datetime "end_at"
  end

  create_table "collects", force: true do |t|
    t.integer  "user_id"
    t.string   "item_type"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recharges", force: true do |t|
    t.integer  "user_id"
    t.string   "scode"
    t.decimal  "amount",     precision: 10, scale: 2, default: 0.0
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string  "name"
    t.string  "state"
    t.string  "resource_type"
    t.integer "resource_id"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", length: {"name"=>100}, using: :btree

  create_table "roles_permissions", force: true do |t|
    t.integer "role_id"
    t.integer "permission_id"
  end

  create_table "single_articles", force: true do |t|
    t.string   "key"
    t.string   "title"
    t.text     "content"
    t.boolean  "can_delete", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_categories", force: true do |t|
    t.string  "name"
    t.integer "position"
  end

  create_table "store_images", force: true do |t|
    t.integer "user_id"
    t.integer "store_id"
    t.string  "image"
    t.integer "position"
  end

  create_table "stores", force: true do |t|
    t.integer  "user_id"
    t.integer  "store_category_id"
    t.string   "state"
    t.integer  "position"
    t.string   "address"
    t.string   "name"
    t.string   "phone"
    t.string   "desc"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trade_info_attrs", force: true do |t|
    t.integer "trade_info_category_attr_id"
    t.integer "trade_info_id"
    t.string  "data_type"
    t.string  "name"
    t.string  "value"
    t.string  "image"
    t.boolean "list_display"
    t.string  "placeholder"
  end

  create_table "trade_info_categories", force: true do |t|
    t.string  "name"
    t.string  "logo"
    t.integer "position"
    t.integer "parent_id"
    t.integer "lft",                                                    null: false
    t.integer "rgt",                                                    null: false
    t.integer "depth",                                   default: 0,    null: false
    t.integer "children_count",                          default: 0,    null: false
    t.boolean "show_price",                              default: true
    t.string  "price_unit"
    t.decimal "price",          precision: 10, scale: 2
  end

  create_table "trade_info_category_attrs", force: true do |t|
    t.integer "trade_info_category_id"
    t.string  "data_type"
    t.string  "name"
    t.integer "position"
    t.string  "options",                limit: 1000
    t.boolean "require",                             default: false
    t.integer "maxlength"
    t.boolean "list_display"
    t.string  "placeholder"
  end

  create_table "trade_info_images", force: true do |t|
    t.integer "user_id"
    t.integer "trade_info_id"
    t.string  "image"
    t.integer "position"
  end

  create_table "trade_infos", force: true do |t|
    t.integer  "trade_info_category_id"
    t.integer  "user_id"
    t.string   "title"
    t.string   "desc"
    t.integer  "position"
    t.decimal  "price",                  precision: 10, scale: 2, default: 0.0
    t.string   "state"
    t.text     "content"
    t.datetime "expired_at"
    t.boolean  "recommend",                                       default: false
    t.boolean  "sticky",                                          default: false
    t.datetime "deleted_at"
    t.integer  "look_count",                                      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "total_fee",              precision: 10, scale: 2
    t.integer  "like_count"
    t.string   "city_code"
    t.string   "district_code"
    t.string   "phone"
  end

  create_table "user_cards", force: true do |t|
    t.integer  "card_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.string   "open_id"
    t.string   "token",         limit: 500
    t.string   "logo",          limit: 1000
    t.string   "state"
    t.string   "truename"
    t.string   "phone"
    t.string   "province_code"
    t.string   "city_code"
    t.string   "street_code"
  end

  create_table "wallets", force: true do |t|
    t.integer "user_id"
    t.decimal "balance",        precision: 10, scale: 2, default: 0.0
    t.decimal "lock",           precision: 10, scale: 2, default: 0.0
    t.integer "score",                                   default: 0
    t.decimal "income_balance", precision: 10, scale: 2, default: 0.0
    t.decimal "income_lock",    precision: 10, scale: 2, default: 0.0
  end

  create_table "wechat_sessions", force: true do |t|
    t.string   "openid",     null: false
    t.string   "hash_store"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wechat_sessions", ["openid"], name: "index_wechat_sessions_on_openid", unique: true, length: {"openid"=>100}, using: :btree

  create_table "withdraws", force: true do |t|
    t.integer  "user_id"
    t.decimal  "amount",     precision: 10, scale: 2, default: 0.0
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
