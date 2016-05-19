class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table "withdraws", force: true do |t|
      t.integer  "user_id"
      t.decimal  "amount",     precision: 10, scale: 2, default: 0.0
      t.string   "state"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
