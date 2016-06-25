class Admin::WithdrawsController < Admin::BaseController
  authorize_resource :class => false
  
  before_action :find_data, except: [:index, :new, :create]
  
  def index
    @withdraws = Withdraw.all
  end
  
  def edit
    
  end
  
  def update
    begin
      @data.send("set_state_#{params[:state]}!")
      flash[:notice] = '操作成功'
    rescue Wallet::InsufficientBalanceException => ex
      flash[:notice] = '操作失败，用户余额不足'
    end
    redirect_to admin_withdraws_path
  end
  
  
  private
  def find_data
    @data = Withdraw.find(params[:id])
  end
  
  def post_params
    params.require(:withdraw).permit!
  end
end
