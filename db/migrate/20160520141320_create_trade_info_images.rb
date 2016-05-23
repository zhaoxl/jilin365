class CreateTradeInfoImages < ActiveRecord::Migration
  def change
    create_table :trade_info_images do |t|
      t.references  :user
      t.references  :trade_info
      t.string      :image
      t.integer     :position
    end
  end
end