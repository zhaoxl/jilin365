class TradeInfoCategoryAttr < ActiveRecord::Base
  include  ConstantExtend
  
  acts_as_list scope: :trade_info_category_id

  DATA_TYPE_STRING  = "STRING"
  DATA_TYPE_LSTRING  = "LSTRING"
  DATA_TYPE_INTEGER = "INTEGER"
  DATA_TYPE_SELECT  = "SELECT"
  DATA_TYPE_TEXT    = "TEXT"
  DATA_TYPE_IMAGE   = "IMAGE"

  belongs_to  :trade_info_category
  
  
end
