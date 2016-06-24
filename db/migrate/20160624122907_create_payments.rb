class CreatePayments < ActiveRecord::Migration
  def change
    create_table "payments", force: true do |t|
      t.integer  "user_id"
      t.string   "item_type"
      t.integer  "item_id"
      t.string   "desc",       limit: 500
      t.string   "scode"
      t.decimal  "amount",                 precision: 10, scale: 2, default: 0.0
      t.string   "state"
      t.string   "goto",       limit: 500
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
