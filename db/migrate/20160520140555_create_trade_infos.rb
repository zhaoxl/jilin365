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
      t.text        :content
      t.datetime    :expired_at
      t.integer     :position
      t.boolean     :recommend, default: false
      t.boolean     :sticky, default: false
      t.datetime    :deleted_at
      t.integer     :look_count, default: 0
      t.timestamps
    end
  end
end