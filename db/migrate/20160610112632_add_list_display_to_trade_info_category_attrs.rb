class AddListDisplayToTradeInfoCategoryAttrs < ActiveRecord::Migration
  def change
    add_column :trade_info_category_attrs, :list_display, :boolean
  end
end
