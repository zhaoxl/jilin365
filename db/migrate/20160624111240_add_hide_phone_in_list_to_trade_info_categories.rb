class AddHidePhoneInListToTradeInfoCategories < ActiveRecord::Migration
  def change
    add_column :trade_info_categories, :hide_phone, :boolean
  end
end
