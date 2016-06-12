class AddPlaceholderToTradeInfoCategoryAttrs < ActiveRecord::Migration
  def change
    add_column :trade_info_category_attrs, :placeholder, :string
  end
end
