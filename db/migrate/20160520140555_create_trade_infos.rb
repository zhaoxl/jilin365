class CreateTradeInfos < ActiveRecord::Migration
  def change
    create_table :trade_infos do |t|
      t.references  :trade_info_category
      t.references  :user
      t.string      :title
      t.string      :desc
      t.integer     :position
      t.decimal     :price, precision: 10, scale: 2, default: 0.0
      t.string      :state
      t.datetime    :expired_at
      t.timestamps
    end
  end
end
