class AddListDisplayToTradeInfoAttrs < ActiveRecord::Migration
  def change
    add_column :trade_info_attrs, :list_display, :boolean
  end
end
