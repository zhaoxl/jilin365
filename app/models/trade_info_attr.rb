class TradeInfoAttr < ActiveRecord::Base
  belongs_to  :trade_info
  
  mount_uploader :image, TradeInfoAttrImageUploader
end
