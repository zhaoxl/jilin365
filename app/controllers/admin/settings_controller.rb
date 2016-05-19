class Admin::SettingsController < Admin::BaseController
  authorize_resource :class => false
  
  def new_user_handsel_coupon
    @data = Setting.find_or_initialize_by(key: :new_user_handsel_coupon)
  end
  
  def new_user_handsel_coupon_save
    setting = Setting.find_or_initialize_by(key: :new_user_handsel_coupon)
    setting.value = params[:setting][:value]
    setting.save

    flash[:success] = "编辑成功"
    redirect_to :back 
  end

  def recharge_card_recharge_handsel
    @data = Setting.find_or_initialize_by(key: :recharge_card_recharge_handsel)
  end
  
  def recharge_card_recharge_handsel_save
    setting = Setting.find_or_initialize_by(key: :recharge_card_recharge_handsel)
    setting.value = params[:setting][:value]
    setting.save

    flash[:success] = "编辑成功"
    redirect_to :back 
  end
  
end
