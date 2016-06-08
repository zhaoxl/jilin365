class Member::OrdersController < Member::BaseController
  def index
    @orders = current_user.orders.order('created_at DESC')
    @orders = @orders.where(state: params[:state]) if params[:state].present?
  end
  
  def show
    begin
      @order = current_user.orders.find(params[:id])
    rescue
      redirect_to member_orders_path and return
    end
  end
  
  def set_state
    begin
      order = Order.find(params[:id])
      order.send("set_state_#{params[:state]}!")
    rescue AASM::InvalidTransition
    end
    flash[:notice] = "操作成功"
    
    redirect_to :back
  end
  
  def delete
    order = Order.find(params[:id])
    order.destroy if order.cancel?
    
    redirect_to member_orders_path
  end
  
  def express
    order = current_user.orders.find(params[:id])
    express_name = order.express
    express_number = order.express_number
    
    conn = Faraday.new(:url => 'http://api.kuaidi100.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.get "/api?id=163a5d8783f7ef61&com=#{express_name}&nu=#{express_number}&show=2&muti=1&order=desc"
    @body = response.body.force_encoding("UTF-8")
    
  end
end
