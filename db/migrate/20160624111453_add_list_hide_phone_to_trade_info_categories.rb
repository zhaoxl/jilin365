class AddListHidePhoneToTradeInfoCategories < ActiveRecord::Migration
  def change
    add_column :trade_info_categories, :list_hide_phone, :boolean
  end
end
