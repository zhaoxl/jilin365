class AddLikeCountToTradeInfos < ActiveRecord::Migration
  def change
    add_column :trade_infos, :like_count, :integer
  end
end
