class Withdraw < ActiveRecord::Base
  belongs_to  :user
  
  
  include AASM

  aasm column: :state do
    state :create, :initial => true
    state :finish
    
    event :set_state_finish, after: :finish_after do
      transitions :from => :create, :to => :finish
    end
  end
  
  def finish_after
    return true unless wallet = Wallet.where(user_id: self.user_id).first

    ActiveRecord::Base.transaction do
      #减少锁定金额
      wallet.income_lock -= self.amount
      raise Wallet::InsufficientBalanceException if wallet.income_lock < 0
      wallet.save

      #记录账本
      book = UserAccountBook.create(
        category: UserAccountBook::CATEGORY_INCOME_BALANCE_WITHDRAW,
        balance_category: UserAccountBook::BALANCE_CATEGORY_INCOME,
        user: self.user,
        item: self,
        amount: self.amount,
        description: "提现成功"
      )
      
      #发送通知
      begin
        msg = Wechat::Message.to(self.user.open_id).template(
          template_id: "Nf20ilJ3l1pc6BIUhGF8t1L11Dh4dfuViRoIbSGcUuo", #提现申请结果通知
          data:  {
            'first' => {value: "#{self.user.truename}，您的取现申请结果如下", color: '#173177'},
            'keyword1' => {value: self.created_at.strftime("%Y-%m-%d %H:%M:%S"), color: '#173177'},
            'keyword2' => {value: "#{self.amount}元", color: '#FF0000'},
            'keyword3' => {value: '申请成功，您的零钱正快马加鞭地赶往您的账户。', color: '#173177'},
            'remark' => {value: "请注意查收，如需帮助请致电400-000-0000", color: '#173177'}
          }
        )
        $wechat_client.template_message_send msg
      rescue Exception => ex
        $log4.error("微信服务消息发送失败:提现申请结果通知")
        $log4.error("Error:#{ex.message}")
      end
    end
  end
  
  
end
