class WechatController < AppBaseController
  before_action :current_user, only: [:pay]
  skip_before_filter :verify_authenticity_token, :only => [:pay_notify, :omniauth_login_callback]
  
  
  layout false
  
  def login
    session[:goto] = params[:goto]
    redirect_to "/auth/wechat"
  end
    
  
  def omniauth_login_callback
    Rails.logger.info "omniauth_login_callback BEGIN----------"
    Rails.logger.info "omniauth_login_callback:provider=>#{auth_hash["provider"]}"
    token = auth_hash["credentials"]["token"]
    open_id = auth_hash["uid"]
    nickname = auth_hash["info"]["nickname"]
    logo = auth_hash["info"]["headimgurl"]
    
    Rails.logger.info "omniauth_login_callback:user_info:result=>#{auth_hash}"
    unless user = User.where(open_id: open_id).first
      user = User.new(open_id: open_id, token: token, name: nickname, logo: logo)
    end
    user.save
    Rails.logger.info "omniauth_login_callback:user=>#{user.inspect}"
    Rails.logger.info "omniauth_login_callback END----------"

    session[:user_id] = user.id
    
    redirect_to session.delete(:goto)||index_index_path
  end
  
  def failure
    redirect_to index_index_path
  end
  
  
  def pay
    payment = Payment.find(params[:id])
    @goto = payment.goto || "/member"
    redirect_to '/member' and return if payment.state != "create"
    Rails.logger.debug("wechat pay begin=======================")
    unifiedorder = {
      body:             payment.desc,
      out_trade_no:     "%08d" % payment.id, # prepay order number
      total_fee:        (payment.amount.to_f*100).to_i,          # 注意：单位是分，不是元
      spbill_create_ip: '127.0.0.1',
      notify_url:       "#{ENV["JILIN365_DOMAIN"]}/wechat/pay_notify",
      trade_type:       'JSAPI',
      nonce_str:        SecureRandom.uuid.tr('-', ''),
      openid:           current_user.open_id
    }
    Rails.logger.debug("unifiedorder_params: #{unifiedorder}")
    res = WxPay::Service.invoke_unifiedorder(unifiedorder)
    if res.success?
      Rails.logger.debug("set prepay_id: #{res["prepay_id"]}")
      @pay_p = {
        appId: ENV["JILIN365_WECHAT_APP_ID"],
        timeStamp: Time.now.to_i.to_s,
        nonceStr: SecureRandom.hex,
        package: "prepay_id=#{res["prepay_id"]}",
        signType: "MD5"
      }
      @pay_sign = WxPay::Sign.generate(@pay_p)
    else
      Rails.logger.debug("set prepay_id fail: #{res}")
    end
    Rails.logger.debug("wechat pay end=======================")
  end
  
  def pay_notify
    Rails.logger.debug("wechat pay_notify begin=======================")
    result = Hash.from_xml(request.body.read)["xml"]
    Rails.logger.debug("wechat notify: #{result}")
    if WxPay::Sign.verify?(result)
      ActiveRecord::Base.transaction do
        pay_serial_number = result["out_trade_no"]
        payment = Payment.find(pay_serial_number.to_i)
        order = payment.item
        payment.set_state_payment!
        order.set_state_payment!
        order.pay_logs.new(
          pay_type: "wechat",
          trade_type: result[:trade_type],
          log: result
        )
        order.save
      end
      Rails.logger.debug("支付成功")
      render xml: {
        return_code: "SUCCESS",
        return_msg: "OK"
      }.to_xml(root: 'xml', dasherize: false)
    else
      Rails.logger.debug("支付失败")
      render xml: {
        return_code: "SUCCESS",
        return_msg: "签名失败"
      }.to_xml(root: 'xml', dasherize: false)
    end
    Rails.logger.debug("wechat pay_notify end=======================")
  end

  
  
  protected

  def auth_hash
    request.env['omniauth.auth']
  end
  
  
  
end
