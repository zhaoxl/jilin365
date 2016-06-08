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
  
  def withdraw
    
  end
  
  def withdraw_save
    begin
      amount = params[:amount].to_f
      unless wallet = current_user.wallet
        raise Wallet::InsufficientBalanceException
      end
      wallet.income_balance -= amount
      wallet.income_lock += amount
      raise Wallet::InsufficientBalanceException if wallet.income_balance < 0
      wallet.save
      
      Withdraw.create(user: current_user, amount: amount)
      flash[:notice] = "申请成功，请等待处理"
    rescue Wallet::InsufficientBalanceException
      flash[:notice] = "余额不足！"
    end
    
    redirect_to :back
  end
  
end
