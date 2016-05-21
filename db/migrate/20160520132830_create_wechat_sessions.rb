class CreateWechatSessions < ActiveRecord::Migration
  def change
    create_table "wechat_sessions", force: true do |t|
      t.string   "openid",     null: false
      t.string   "hash_store"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    add_index "wechat_sessions", ["openid"], name: "index_wechat_sessions_on_openid", unique: true, using: :btree, length: 100
    
  end
end
