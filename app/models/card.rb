class Card < ActiveRecord::Base
  enum category: [:coupon_card, :discount_card]
  
  belongs_to  :store
  belongs_to  :user
  
  mount_uploader :logo, CardLogoUploader
  
  
end
