class CreateAdmins < ActiveRecord::Migration
  def change
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

    add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree, length: 100
    add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree, length: 100
    
  end
end
