class AddPhoneToTradeInfos < ActiveRecord::Migration
  def change
    add_column :trade_infos, :phone, :string
  end
end
