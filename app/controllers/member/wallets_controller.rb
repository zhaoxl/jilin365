class Member::WalletsController < Member::BaseController
  def index
  end
  
  def new
    
  end
  
  def create
    scode = params[:scode]
    if card = RechargeCard.where(scode: scode, state: :create).first
      current_user.recharge(card)
      redirect_to "/member" and return
    else
      flash[:error] = "卡号错误！"
    end
    redirect_to :back
  end
  
end
