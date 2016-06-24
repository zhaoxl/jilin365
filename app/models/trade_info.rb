class TradeInfo < ActiveRecord::Base
  acts_as_paranoid
  acts_as_list  scope: :trade_info_category_id
  
  belongs_to  :trade_info_category
  has_many    :trade_info_images, -> { order('position ASC') }, :dependent => :destroy
  has_many    :trade_info_attrs, :dependent => :destroy
  
  include AASM

  aasm column: :state do
    state :cancel
    state :create, :initial => true
    state :pass
    state :payment
    state :lock
    state :expire
    
    event :set_state_cancel do
      transitions :from => :create, :to => :cancel
    end
    
    event :set_state_payment do
      transitions :from => [:create], :to => :payment
    end
    
    event :set_state_lock do
      transitions :from => :pass, :to => :lock
    end
    
    event :set_state_expire do
      transitions :from => [:pass, :lock], :to => :expire
    end
  end
  
  def front_image
    self.trade_info_images.first.try(:image)
  end
  
end
