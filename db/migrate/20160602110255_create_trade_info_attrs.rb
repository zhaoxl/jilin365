class CreateTradeInfoAttrs < ActiveRecord::Migration
  def change
    create_table :trade_info_attrs do |t|
      t.references  :trade_info
      t.references  :trade_info_category_attr
      t.string      :data_type
      t.string      :name
      t.string      :value
      t.string      :image
    end
  end
end
