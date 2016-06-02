class TradeInfoCategoryAttr < ActiveRecord::Base
  acts_as_list
  
  DATA_TYPE_INTEGER = "INTEGER"
  DATA_TYPE_STRING  = "STRING"
  DATA_TYPE_TEXT    = "TEXT"
  DATA_TYPE_IMAGE   = "IMAGE"

  belongs_to  :trade_info_category
  
  
end
