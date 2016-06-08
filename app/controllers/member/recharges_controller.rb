class Member::RechargesController < Member::BaseController
  def new
    
  end
  
  def create
    
    begin
      raise Exception, '金额太小' if params[:amount].to_f < 1
      recharge = Recharge.create(user: current_user, amount: params[:amount].to_f)
      redirect_to new_member_payment_path(item_type: recharge.class.name, item_id: recharge.id) and return
    rescue Exception => ex
      flash[:notice] = ex.message
    end
    redirect_to :back
  end
end
