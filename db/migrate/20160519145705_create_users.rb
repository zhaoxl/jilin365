class CreateUsers < ActiveRecord::Migration
  def change
    create_table "users", force: true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.integer  "recommend_user_id"
      t.string   "open_id"
      t.string   "token",             limit: 500
      t.string   "headimgurl",        limit: 1000
      t.string   "qrcode"
      t.string   "state"
      t.integer  "level",                          default: 1
      t.string   "lock_reason",       limit: 1000
      t.string   "truename"
      t.string   "phone"
      t.string   "province_code"
      t.string   "city_code"
      t.string   "street_code"
    end
  end
end
