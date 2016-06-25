class Payment < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :item, polymorphic: true
  
  include AASM

  aasm column: :state do
    state :cancel
    state :create, :initial => true
    state :payment
    
    event :set_state_cancel do
      transitions :from => :create, :to => :cancel
    end
    
    event :set_state_payment, after: :payment_after do
      transitions :from => :create, :to => :payment
    end
  end
  
  def payment_after
    ActiveRecord::Base.transaction do
      case self.item_type
      when "TradeInfo" then
        #记录账本
        book = UserAccountBook.create(
          category: UserAccountBook::CATEGORY_TRADE_INFO_PAYMENT,
          balance_category: UserAccountBook::BALANCE_CATEGORY_PAYMENT,
          user: self.user,
          item: self.item,
          amount: self.amount,
          title: "供求信息",
          description: self.item.try(:title)
        )
      end
    end
  end
  
end
