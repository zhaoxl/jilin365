class AddShowPriceToTradeInfos < ActiveRecord::Migration
  def change
    add_column :trade_infos, :total_fee, :decimal, precision: 10, scale: 2
  end
end
