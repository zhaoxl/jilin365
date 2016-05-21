class Recharge < ActiveRecord::Base
  belongs_to  :user
  has_many    :pay_logs, :as => :item
  
  include AASM

  aasm column: :state do
    state :cancel
    state :create, :initial => true
    state :payment
    
    event :set_state_cancel do
      transitions :from => :create, :to => :cancel
    end
    
    event :set_state_payment, after: :payment_callback do
      transitions :from => :create, :to => :payment
    end
  end
  
  before_create :before_create_callback
  
  #支付成功callback
  def payment_callback
    #钱包充值
    Wallet.recharge(self.user, self)
    
    #记录账本
    UserAccountBook.create(
      category: UserAccountBook::CATEGORY_RECHARGE_PAYMENT,
      balance_category: UserAccountBook::BALANCE_CATEGORY_WALLET,
      user: self.user,
      item: self,
      amount: self.amount,
      description: "充值成功"
    )
  end
  
  def before_create_callback
    #生成订单号
    today_order_count = Recharge.where("TO_DAYS(created_at) = TO_DAYS(NOW())").count+1
    today_order_count = "%05d" % today_order_count.to_s
    rand_code = "%03d" % rand(1000).to_s
    self.scode = "#{Time.now.strftime("%y%m%d%H%M%S")}#{today_order_count}#{rand_code}"
  end
  
  
  
end
