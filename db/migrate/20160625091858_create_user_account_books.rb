class CreateUserAccountBooks < ActiveRecord::Migration
  def change
    create_table "user_account_books", force: true do |t|
      t.string   "category"
      t.integer  "user_id"
      t.string   "item_type"
      t.integer  "item_id"
      t.decimal  "amount",                        precision: 10, scale: 2, default: 0.0
      t.string   "description",      limit: 2000
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "balance_category"
    end
  end
end
