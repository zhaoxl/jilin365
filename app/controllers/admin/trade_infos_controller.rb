class Admin::TradeInfosController < Admin::BaseController
  # authorize_resource :class => false
  
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @datas = TradeInfo.order("id desc")
    @datas = @datas.where("name LIKE ?", "%#{params[:title]}%") if params[:name].present?
    @datas = @datas.where(state: params[:state]) if params[:state].present?
    @datas = @datas.page(params[:page]).per(100)
  end
  
  def new
    @data = TradeInfo.new
  end
  
  def create
    data = TradeInfo.new(post_params)
    data.save
    flash[:success] = "添加成功"
    
    redirect_to admin_trade_info_trade_info_images_path(data)
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    flash[:success] = "编辑成功"
    
    redirect_to :back 
  end

  
  def destroy
    @data.destroy!
    redirect_to :back, notice: '删除成功'
  end
  
  def move_down
    @data.move_lower
    redirect_to :back
  end
  
  def move_up
    @data.move_higher
    redirect_to :back
  end
  
  def set_state
    begin
      @data.send("set_state_#{params[:state]}!")
      #如果是下架，在所有人购物车中删除这个产品
      Cart.where(data: @data).destroy_all if @data.state.pause?
      flash[:success] = "设置成功"
    rescue
      flash[:notice] = "设置失败"
    end
    redirect_to :back
  end
  
  private
  def find_data
    @data = TradeInfo.find(params[:id])
  end
  
  def post_params
    params.require(:trade_info).permit!
  end
  
  
  
end
 