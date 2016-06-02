class TradeInfoCategory < ActiveRecord::Base
  acts_as_list
  acts_as_nested_set :order_column => :position
  
  has_many  :trade_infos, -> { order('position ASC') }
  has_many  :trade_info_category_attrs
  
  
  mount_uploader :logo, TradeInfoCategoryLogoUploader
  
  def can_delete?
    !self.trade_infos.exists?
  end
  
  
end
