class Member::WithdrawsController < Member::BaseController
  def index
    @logs = current_user.withdraws.order("id DESC")
  end
  
  
  def create
    begin
      amount = params[:amount].to_f
      unless wallet = current_user.wallet
        raise Wallet::InsufficientBalanceException
      end
      wallet.balance -= amount
      wallet.lock += amount
      raise Wallet::InsufficientBalanceException if wallet.balance < 0
      wallet.save
      
      Withdraw.create(user: current_user, amount: amount)
      flash[:notice] = "申请成功，请等待处理"
    rescue Wallet::InsufficientBalanceException
      flash[:notice] = "余额不足！"
    end
    
    redirect_to :back
  end
end
