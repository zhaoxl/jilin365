class AddPlaceholderToTradeInfoAttrs < ActiveRecord::Migration
  def change
    add_column :trade_info_attrs, :placeholder, :string
  end
end
