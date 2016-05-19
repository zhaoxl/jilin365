class Admin::OrdersController < Admin::BaseController
  authorize_resource :class => false
  
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @orders = Order.where("").order("created_at DESC")
    @orders = @orders.where(state: params[:state]) if params[:state].present?
    @orders = @orders.where("scode LIKE ?", "%#{params[:scode]}%") if params[:scode].present?
    @orders = @orders.joins("INNER JOIN users ON users.id = orders.user_id").where("users.name LIKE ? OR users.truename LIKE ?", "%#{params[:user]}%", "%#{params[:user]}%") if params[:user].present?
    if params[:user_id].present?
      @orders = @orders.where(user_id: params[:user_id])
      @user = User.find(params[:user_id]) rescue nil
    end
    @orders = @orders.page(params[:page]).per(20)
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    flash[:success] = "编辑成功"
    
    redirect_to :back 
  end
  
  def sent
    
  end
  
  def sent_save
    begin
      @data.set_state_sent!
    rescue AASM::InvalidTransition
    end
    @data.update_attributes(post_params)
    flash[:success] = "发货成功"
    
    redirect_to admin_orders_path
  end
  
  def state
    
  end
  
  def state_save
    begin
      @data.send("set_state_#{params[:order][:state]}!") if ["cancel", "create", "payment", "receive"].include?(params[:order][:state])
      flash[:success] = "操作成功"
    rescue AASM::InvalidTransition
      flash[:notice] = "状态修改失败"
     end
    
    redirect_to admin_orders_path
  end
  
  private
  def find_data
    @data = Order.find(params[:id])
  end
  
  def post_params
    params.require(:order).permit!
  end
  
  
  
end
 