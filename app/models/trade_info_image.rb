class TradeInfoImage < ActiveRecord::Base
  acts_as_list  scope: :trade_info_id
  
  belongs_to  :user
  belongs_to  :trade_info
  
  mount_uploader :image, TradeInfoImageUploader
  
end
