class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to  :recommend_user, class_name: "User", foreign_key: :recommend_user_id

  
  has_one   :wallet
  
  
  after_create :after_create_callback
  
  # mount_uploader :logo, UserLogoUploader
  
  include AASM

  aasm column: :state do
    state :lock
    state :temp_lock
    state :create, :initial => true
    
    event :set_state_create do
      transitions :from => [:lock, :temp_lock], :to => :create
    end
     
    event :set_state_temp_lock do
      transitions :from => :create, :to => :temp_lock
    end
    
    event :set_state_lock do
      transitions :from => [:create, :temp_lock], :to => :lock
    end
  end
  
  
  def is_distribution?
    self.distribution && !["cancel", "create"].include?(self.distribution.state)
  end
  
  def balance
    self.wallet.try(:balance).to_f
  end
  
  def income_balance
    self.wallet.try(:income_balance).to_f
  end
  
  def balance=(val)
    self_wallet = self.wallet||self.build_wallet
    self_wallet.balance = val.to_f
    self_wallet.save
  end
  
  def score
    self.wallet.try(:score).to_i
  end
  
  def score=(val)
    self_wallet = self.wallet||self.build_wallet(balance: 0, score: 0)
    self_wallet.score = val.to_f
    self_wallet.save
  end
  
  #充值卡充值
  def recharge(card)
    ActiveRecord::Base.transaction do
      #修改充值卡状态
      card.user = self
      card.set_state_used!
      #根据设置调整赠送金额
      handsel = 0
      if setting = Setting.where(key: :recharge_card_recharge_handsel).first
        handsel = (card.price * setting.value.to_f) / 100
      end
      
      #加上充值卡赠送的金额
      handsel += card.handsel
    
      unless w = self.wallet
        w = self.build_wallet(balance: 0, score: 0)
      end
      w.balance += card.price + handsel
      w.save
    end
  end
  
  #获得分销分红
  def dividend(order)
    self_wallet = self.wallet||self.build_wallet(balance: 0, score: 0)
    amount = order.total_fee*0.15
    self_wallet.balance += amount
    self_wallet.save
    
    DividendLog.create(user: order.user, recommend_user: self, order: order, amount: amount)
  end
  
  #用户升级
  def upgrade(to)
    self.update_attribute(:level, to) if self.level < to.to_i
    #如果有上级推荐用户，则给他发送升级通知
    if ruser = self.father
      begin
        msg = Wechat::Message.to(ruser.open_id).template(
          template_id: "w0nlgNLFyxKMJgk1CMBO1EI9vjVcd9pDTMXXq0CBVqc", #下级升级通知
          url: "#{Settings.base}/member",
          data:  {
            'first' =>    {value: "以下会员已经升级为V#{to}", color: '#FF0000'},
            'keyword1' => {value: self.name, color: '#173177'},
            'keyword2' => {value: Time.now.strftime("%Y-%m-%d %H:%M:%S"), color: '#173177'}
          }
        )
        $wechat_client.template_message_send msg
      rescue Exception => ex
        $log4.error("微信服务消息发送失败:用户升级")
        $log4.error("Error:#{ex.message}")
      end
    end
    
    return true
  end
  
  def after_create_callback
    #如果有上级推荐用户，则给他发送进入系统通知
    if ruser = self.father
      begin
        msg = Wechat::Message.to(ruser.open_id).template(
          template_id: "yeGDI2RExqPglQ5ObCfcdcpwTrZ6oKACfhtyZANL0uQ", #邀请关注成功通知
          url: "#{Settings.base}/member/recommends",
          data:  {
            'first' =>    {value: '以下会员已经通过您分享的二维码加入系统', color: '#173177'},
            'keyword1' => {value: self.name, color: '#173177'},
            'keyword2' => {value: self.created_at.strftime("%Y-%m-%d %H:%M:%S"), color: '#173177'},
            'keyword3' => {value: ruser.name, color: '#173177'}
          }
        )
        $wechat_client.template_message_send msg
      rescue Exception => ex
        $log4.error("微信服务消息发送失败:被邀请用户进入系统")
        $log4.error("Error:#{ex.message}")
      end
    end
  end
  
  #上级用户
  def father
    self.recommend_user
  end
  
  #上级的上级用户
  def grandfather
    if self_father = self.father
      self_father.father
    end
  end
  
  #上级的上级的上级用户
  def great_grandfather
    if self_grandfather = self.grandfather
      self_grandfather.father
    end
  end
  
  #实际订单额
  def raw_order_total_fee(year=nil, month=nil, day=nil)
    #实际销售额
    all_orders = Order.where(user_id: self.id).where(state: :receive).select("*,SUM(total_fee-fare) AS all_fee")
    all_orders = all_orders.where("date_format(receive_at,'%Y')=?", year) if year.present?
    all_orders = all_orders.where("date_format(receive_at,'%m')=?", month) if month.present?
    all_orders = all_orders.where("date_format(receive_at,'%d')=?", day) if day.present?
    all_fee = BigDecimal.new(all_orders.first.try(:all_fee).to_s)
  end
   
  #是否完成基本任务
  def finish_basic_task?(year=nil, month=nil, day=nil)
    #基本任务
    basic_task = UserLevel.basic_task(self.level)
    #实际订单额
    raw_order_total_fee(year, month, day)
    
    return raw_order_total_fee >= basic_task
  end
  
  #是否完成最低任务
  def finish_lowest_task?(year=nil, month=nil, day=nil)
    #最低任务
    lowest_task = UserLevel.lowest_task(self.level)
    #实际订单额
    raw_order_total_fee(year, month, day)
    
    return raw_order_total_fee >= lowest_task
  end
  
  
  
end
