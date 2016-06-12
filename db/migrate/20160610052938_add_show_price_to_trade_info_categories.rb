class AddShowPriceToTradeInfoCategories < ActiveRecord::Migration
  def change
    add_column :trade_info_categories, :show_price, :boolean, default: true
    add_column :trade_info_categories, :price_unit, :string
    add_column :trade_info_categories, :price, :decimal, precision: 10, scale: 2
  end
end
