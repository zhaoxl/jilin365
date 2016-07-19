class TradeInfoUserLike < ActiveRecord::Base
  class LikeCountOverflowException < Exception
  end
  
  belongs_to  :trade_info
  belongs_to  :user
  
  TODAY_MAX_LIKE = 2
  
  def self.can_like?(user, trade_info)
    TradeInfoUserLike.where("created_at >= ?", Time.now.beginning_of_day).where(user: user, trade_info: trade_info).count < TradeInfoUserLike::TODAY_MAX_LIKE
  end
  
  def self.like(user, trade_info)
    raise TradeInfoUserLike::LikeCountOverflowException unless TradeInfoUserLike.can_like?(user, trade_info)
    TradeInfoUserLike.create(user: user, trade_info: trade_info)
    trade_info.class.increment_counter(:like_count, trade_info.id)
  end
  
  
end
