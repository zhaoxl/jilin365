class AddMaxlengthToTradeInfoCategoryAttrs < ActiveRecord::Migration
  def change
    add_column :trade_info_category_attrs, :maxlength, :integer
  end
end
