class Card < ActiveRecord::Base
  acts_as_paranoid
  enum category: [:coupon_card, :discount_card]
  
  belongs_to  :store
  belongs_to  :user
  has_many    :user_cards
  
  mount_uploader :logo, CardLogoUploader
  
    
  def can_delete?
    return true
  end
  
  
end
