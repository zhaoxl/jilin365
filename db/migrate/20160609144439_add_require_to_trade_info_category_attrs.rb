class AddRequireToTradeInfoCategoryAttrs < ActiveRecord::Migration
  def change
    add_column :trade_info_category_attrs, :require, :boolean, default: false
  end
end
