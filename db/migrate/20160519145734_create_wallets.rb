class CreateWallets < ActiveRecord::Migration
  def change
    create_table "wallets", force: true do |t|
      t.integer "user_id"
      t.decimal "balance",        precision: 10, scale: 2, default: 0.0
      t.decimal "lock",           precision: 10, scale: 2, default: 0.0
      t.integer "score",                                   default: 0
      t.decimal "income_balance", precision: 10, scale: 2, default: 0.0
      t.decimal "income_lock",    precision: 10, scale: 2, default: 0.0
    end
  end
end
