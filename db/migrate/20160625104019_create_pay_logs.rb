class CreatePayLogs < ActiveRecord::Migration
  def change
    create_table "pay_logs", force: true do |t|
      t.string   "item_type"
      t.integer  "item_id"
      t.string   "pay_type"
      t.string   "trade_type"
      t.string   "log",        limit: 5000
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
