class Member::PaymentsController < Member::BaseController
  def create
    begin
      amount = 0
      category = params[:category]
      payment = Payment.new(item_type: params[:item_type], item_id: params[:item_id], user_id: current_user.id)
      order = params[:item_type].constantize.find(payment.item_id)
      ActiveRecord::Base.transaction do
        case category
        when "wallet" then
          if payment.item_type == "Order"
            payment.amount = order.total_fee
            payment.desc = order.to_s
            payment.goto = "/member/orders/#{order.id}"
            payment.save
          end
          #钱包扣款
          Wallet.waste(current_user, payment)
          payment.set_state_payment!
          order.set_state_payment!
          redirect_to payment.goto and return if payment.goto.present?
        when "wechat" then
          if payment.item_type == "TradeInfo"
            payment.amount = order.total_fee
            payment.desc = order.title
            payment.goto = "/member/trade_infos"
            payment.save
          elsif payment.item_type == "Recharge"
            payment.amount = order.amount
            payment.desc = "充值#{order.amount}元"
            payment.goto = "/member"
            payment.save
          end
          #跳转微信支付
          redirect_to "/wechat/pay?id=#{payment.id}" and return
        end
      end
    
    rescue Wallet::InsufficientBalanceException
      redirect_to :back, notice: '余额不足' and return
    end
    redirect_to '/member'
  end
  
  
end
