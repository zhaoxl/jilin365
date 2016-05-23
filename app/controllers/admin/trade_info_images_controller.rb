class Admin::TradeInfoImagesController < Admin::BaseController
  # authorize_resource :class => false
  
  before_action :find_trade_info
  before_action :find_data, except: [:index, :new, :create]
  
  def index
    @datas = @trade_info.trade_info_images
  end
  
  def new
    @data = @trade_info.trade_info_images.build
  end
  
  def create
    image = @trade_info.trade_info_images.build(post_params)
    image.save!
    
    redirect_to admin_trade_info_trade_info_images_path(@trade_info), notice: '添加成功'
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    
    redirect_to admin_trade_info_trade_info_images_path(@trade_info), notice: '编辑成功'
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
  
  private
  def find_trade_info
    @trade_info = TradeInfo.find(params[:trade_info_id])
  end
  
  def find_data
    @data = ProductLogo.find(params[:id])
  end
  
  def post_params
    params.require(:trade_info_image).permit!
  end
end
