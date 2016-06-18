class AddAreaCodeToTradeInfos < ActiveRecord::Migration
  def change
    add_column :trade_infos, :city_code, :string
    add_column :trade_infos, :district_code, :string
  end
end
