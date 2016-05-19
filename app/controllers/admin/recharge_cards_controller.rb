class Admin::RechargeCardsController < Admin::BaseController
  authorize_resource :class => false
  
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @recharge_cards = RechargeCard.all
  end
  
  def new
    @product = RechargeCard.new
  end
  
  def create
    1.upto(params[:total].to_i) do |index|
      RechargeCard.create(handsel: params[:handsel].to_f, price: params[:price].to_f, scode: "100#{rand(1000000000000000..9999999999999999)}")
    end
    
    flash[:success] = "添加成功#{params[:total]}条"
    
    redirect_to :back 
  end
  

  
  def destroy
    @data.destroy! if @data.create?
    redirect_to :back, notice: '删除成功'
  end
  
  def set_state
    begin
      @data.send("set_state_#{params[:state]}!")
      #如果是下架，在所有人购物车中删除这个产品
      Cart.where(product: @data).destroy_all if @data.state.pause?
      flash[:success] = "设置成功"
    rescue
      flash[:notice] = "设置失败"
    end
    redirect_to :back
  end
  
  private
  def find_data
    @data = RechargeCard.find(params[:id])
  end

  
  
  
end
 