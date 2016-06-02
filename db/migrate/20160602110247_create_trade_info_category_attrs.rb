class CreateTradeInfoCategoryAttrs < ActiveRecord::Migration
  def change
    create_table :trade_info_category_attrs do |t|
      t.references  :trade_info_category
      t.string      :data_type
      t.string      :name
      t.integer     :position
    end
  end
end
