class WechatController < AppBaseController
  before_action :current_user, only: [:pay]
  skip_before_filter :verify_authenticity_token, :only => [:pay_notify]
  
  
  layout false
  
  def login
    session[:goto] = params[:goto]
    redirect_to "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{Settings.wechat.appid}&redirect_uri=#{Settings.base}/wechat/login_get_code_callback&response_type=code&scope=snsapi_userinfo&state=#{params[:recommend].to_i}#wechat_redirect"
  end
  
  def login_get_code_callback
    code = params[:code]
    url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Settings.wechat.appid}&secret=#{Settings.wechat.secret}&code=#{code}&grant_type=authorization_code"
    
    result = JSON.parse(URI.parse(url).read)
    open_id = result["openid"]
    token = result["access_token"]
    
    
    unless user = User.where(open_id: open_id).first
      #获取用户资料
      url = "https://api.weixin.qq.com/sns/userinfo?access_token=#{token}&openid=#{open_id}&lang=zh_CN"
      result = JSON.parse(URI.parse(url).read)
      nickname = result["nickname"]
      headimgurl = result["headimgurl"]
      
      user = User.new(open_id: open_id, token: token, name: nickname, headimgurl: headimgurl, level: 1)
      user.save!
      
      # #新用户赠送优惠券
      # if setting = Setting.where(key: :new_user_handsel_coupon).first
      #   if setting.value.to_i > 0
      #     if coupon_template = CouponTemplate.where(id: setting.value).first
      #       Coupon.create(user: user, coupon_template: coupon_template, name: coupon_template.name, price: coupon_template.price)
      #     end
      #   end
      # end
    end
    session[:user_id] = user.id
    
    if session[:goto].present?
      redirect_to session.delete(:goto) and return
    else
      redirect_to "/?recommend=#{params[:state]}" and return
    end
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
      notify_url:       'http://jt.fannybay.net/wechat/pay_notify',
      trade_type:       'JSAPI',
      nonce_str:        SecureRandom.uuid.tr('-', ''),
      openid:           current_user.open_id
    }
    Rails.logger.debug("unifiedorder_params: #{unifiedorder}")
    res = WxPay::Service.invoke_unifiedorder(unifiedorder)
    if res.success?
      Rails.logger.debug("set prepay_id: #{res["prepay_id"]}")
      @pay_p = {
        appId: Settings.wechat.appid,
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
      #TODO:支付成功后，减库存
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
  
end
