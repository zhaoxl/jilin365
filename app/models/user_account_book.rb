class UserAccountBook < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :item, :polymorphic => true 
  
  delegate :open_id, to: :user, allow_nil: true
  
  #记账类型
  
  CATEGORY_WALLET_BALANCE_WITHDRAW =                          "WALLET_BALANCE_WITHDRAW"                           #余额提现
  CATEGORY_TRADE_INFO_PAYMENT =                               "TRADE_INFO_PAYMENT"                                #供求信息支付完成
  CATEGORY_RECOMMEND_FIRST_REBATE =                           "RECOMMEND_FIRST_REBATE"                            #推荐首单返利
  CATEGORY_SELF_ORDER_FINISH_REBATE =                         "SELF_ORDER_FINISH_REBATE"                          #自己订单完成返利
  CATEGORY_ORDER_FINISH_FATHER_RECOMMEND_REBATE =             "ORDER_FINISH_FATHER_RECOMMEND_REBATE"              #订单完成1级推荐用户业绩奖
  CATEGORY_ORDER_FINISH_GRANDFATHER_RECOMMEND_REBATE =        "ORDER_FINISH_GRANDFATHER_RECOMMEND_REBATE"         #订单完成2级推荐用户业绩奖
  CATEGORY_ORDER_FINISH_GRAND_GRANDFATHER_RECOMMEND_REBATE =  "ORDER_FINISH_GRAND_GRANDFATHER_RECOMMEND_REBATE"   #订单完成3级推荐用户业绩奖
  CATEGORY_MONTH_SETTLE_AREA_REBATE =                         "MONTH_SETTLE_AREA_REBATE"                          #月度结算区域奖
  CATEGORY_MONTH_COMPARE_FIRST_REBATE =                       "MONTH_COMPARE_FIRST_REBATE"                        #月度结算评比奖比例——第1名
  CATEGORY_MONTH_COMPARE_SECOND_REBATE =                      "MONTH_COMPARE_SECOND_REBATE"                       #月度结算评比奖比例——第2名
  CATEGORY_MONTH_COMPARE_THIRD_REBATE =                       "MONTH_COMPARE_THIRD_REBATE"                        #月度结算评比奖比例——第3名
  CATEGORY_MONTH_TEAM_MANAGE_REBATE =                         "MONTH_TEAM_MANAGE_REBATE"                          #月度结算团队管理奖
  CATEGORY_ORDER_PAYMENT =                                    "ORDER_PAYMENT"                                     #订单支付成功
  CATEGORY_RECHARGE_PAYMENT =                                 "RECHARGE_PAYMENT"                                  #充值支付成功
  CATEGORY_INCOME_BALANCE_WITHDRAW =                          "INCOME_BALANCE_WITHDRAW"                           #收益提现
  
  #余额类型
  BALANCE_CATEGORY_WALLET =                                   "WALLET"                                            #钱包
  BALANCE_CATEGORY_INCOME =                                   "INCOME"                                            #收益账户
  BALANCE_CATEGORY_PAYMENT =                                  "支付平台"                                           #支付平台
  
  after_create :send_message
  
  #账户变动发送通知
  def send_message
    case self.category
    when UserAccountBook::CATEGORY_RECOMMEND_FIRST_REBATE then
      #推荐首单回扣
      if user_openid = self.open_id
        begin
          msg = Wechat::Message.to(user_openid).template(
            template_id: "itWHvAx_4SDaLKlTK21_gMDVKzaujj873iFgEzOmBrE", #收益通知
            url: "#{Settings.base}/member/account_books/#{self.id}",
            data:  {
              'keyword1' => {value: '被推荐人成为VIP', color: '#173177'},
              'keyword2' => {value: "#{self.amount}元", color: '#FF0000'},
              'keyword3' => {value: self.created_at.strftime("%Y-%m-%d %H:%M:%S"), color: '#173177'},
              'keyword4' => {value: "#{self.user.income_balance}元", color: '#FF0000'}
            }
          )
          $wechat_client.template_message_send msg
        rescue Exception => ex
          $log4.error("微信服务消息发送失败:推荐首单回扣")
          $log4.error("Error:#{ex.message}")
        end
      end
    when UserAccountBook::CATEGORY_SELF_ORDER_FINISH_REBATE then
      #自己订单完成返利
      begin
        msg = Wechat::Message.to(self.open_id).template(
          template_id: "itWHvAx_4SDaLKlTK21_gMDVKzaujj873iFgEzOmBrE", #收益通知
          url: "#{Settings.base}/member/account_books/#{self.id}",
          data:  {
            'keyword1' => {value: '订单成功返利', color: '#173177'},
            'keyword2' => {value: "#{self.amount}元", color: '#FF0000'},
            'keyword3' => {value: self.created_at.strftime("%Y-%m-%d %H:%M:%S"), color: '#173177'},
            'keyword4' => {value: "#{self.user.income_balance}元", color: '#FF0000'}
          }
        )
        $wechat_client.template_message_send msg
      rescue Exception => ex
        $log4.error("微信服务消息发送失败:自己订单完成返利")
        $log4.error("Error:#{ex.message}")
      end
    when UserAccountBook::CATEGORY_ORDER_FINISH_FATHER_RECOMMEND_REBATE then
      #订单完成1级推荐用户业绩奖
      begin
        msg = Wechat::Message.to(self.open_id).template(
          template_id: "itWHvAx_4SDaLKlTK21_gMDVKzaujj873iFgEzOmBrE", #收益通知
          url: "#{Settings.base}/member/account_books/#{self.id}",
          data:  {
            'keyword1' => {value: '订单完成1级推荐用户业绩奖', color: '#173177'},
            'keyword2' => {value: "#{self.amount}元", color: '#FF0000'},
            'keyword3' => {value: self.created_at.strftime("%Y-%m-%d %H:%M:%S"), color: '#173177'},
            'keyword4' => {value: "#{self.user.income_balance}元", color: '#FF0000'}
          }
        )
        $wechat_client.template_message_send msg
      rescue Exception => ex
        $log4.error("微信服务消息发送失败:订单完成1级推荐用户业绩奖")
        $log4.error("Error:#{ex.message}")
      end
    when UserAccountBook::CATEGORY_ORDER_FINISH_GRANDFATHER_RECOMMEND_REBATE then
      #订单完成2级推荐用户业绩奖
      begin
        msg = Wechat::Message.to(self.open_id).template(
          template_id: "itWHvAx_4SDaLKlTK21_gMDVKzaujj873iFgEzOmBrE", #收益通知
          url: "#{Settings.base}/member/account_books/#{self.id}",
          data:  {
            'keyword1' => {value: '订单完成2级推荐用户业绩奖', color: '#173177'},
            'keyword2' => {value: "#{self.amount}元", color: '#FF0000'},
            'keyword3' => {value: self.created_at.strftime("%Y-%m-%d %H:%M:%S"), color: '#173177'},
            'keyword4' => {value: "#{self.user.income_balance}元", color: '#FF0000'}
          }
        )
        $wechat_client.template_message_send msg
      rescue Exception => ex
        $log4.error("微信服务消息发送失败:订单完成2级推荐用户业绩奖")
        $log4.error("Error:#{ex.message}")
      end
    when UserAccountBook::CATEGORY_ORDER_FINISH_GRAND_GRANDFATHER_RECOMMEND_REBATE then
      #订单完成3级推荐用户业绩奖
      begin
        msg = Wechat::Message.to(self.open_id).template(
          template_id: "itWHvAx_4SDaLKlTK21_gMDVKzaujj873iFgEzOmBrE", #收益通知
          url: "#{Settings.base}/member/account_books/#{self.id}",
          data:  {
            'keyword1' => {value: '订单完成3级推荐用户业绩奖', color: '#173177'},
            'keyword2' => {value: "#{self.amount}元", color: '#FF0000'},
            'keyword3' => {value: self.created_at.strftime("%Y-%m-%d %H:%M:%S"), color: '#173177'},
            'keyword4' => {value: "#{self.user.income_balance}元", color: '#FF0000'}
          }
        )
        $wechat_client.template_message_send msg
      rescue Exception => ex
        $log4.error("微信服务消息发送失败:订单完成3级推荐用户业绩奖")
        $log4.error("Error:#{ex.message}")
      end
    when UserAccountBook::CATEGORY_MONTH_SETTLE_AREA_REBATE then
      #月度结算——区域奖
      begin
        msg = Wechat::Message.to(self.open_id).template(
          template_id: "itWHvAx_4SDaLKlTK21_gMDVKzaujj873iFgEzOmBrE", #收益通知
          url: "#{Settings.base}/member/account_books/#{self.id}",
          data:  {
            'first' => {value: '您的上月收益已经到账', color: '#173177'},
            'keyword1' => {value: '月度结算——区域奖', color: '#173177'},
            'keyword2' => {value: "#{self.amount}元", color: '#FF0000'},
            'keyword3' => {value: self.created_at.strftime("%Y-%m-%d %H:%M:%S"), color: '#173177'},
            'keyword4' => {value: "#{self.user.income_balance}元", color: '#FF0000'},
            'remark' => {value: self.item.desc, color: '#FF0000'}
          }
        )
        $wechat_client.template_message_send msg
      rescue Exception => ex
        $log4.error("微信服务消息发送失败:月度结算——区域奖")
        $log4.error("Error:#{ex.message}")
      end
    when UserAccountBook::CATEGORY_MONTH_TEAM_MANAGE_REBATE then
      #月度结算团队管理奖
      begin
        msg = Wechat::Message.to(self.open_id).template(
          template_id: "itWHvAx_4SDaLKlTK21_gMDVKzaujj873iFgEzOmBrE", #收益通知
          url: "#{Settings.base}/member/account_books/#{self.id}",
          data:  {
            'keyword1' => {value: '月度结算团队管理奖', color: '#173177'},
            'keyword2' => {value: "#{self.amount}元", color: '#FF0000'},
            'keyword3' => {value: self.created_at.strftime("%Y-%m-%d %H:%M:%S"), color: '#173177'},
            'keyword4' => {value: "#{self.user.income_balance}元", color: '#FF0000'}
          }
        )
        $wechat_client.template_message_send msg
      rescue Exception => ex
        $log4.error("微信服务消息发送失败:月度结算团队管理奖")
        $log4.error("Error:#{ex.message}")
      end
    end
  end
  
  #关联对象名称
  def item_name
    case self.item_type
    when "Order" then
      "订单"
    when "RebateLog" then
      "结算返利"
    end
  end
  
end



