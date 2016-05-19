class Admin::BannersController < Admin::BaseController
  authorize_resource :class => false
  
  before_action :find_data, except: [:index, :new, :create]
  
  def index
    @banners = Banner.all
  end
  
  def new
    @data = Banner.new
  end
  
  def create
    banner = Banner.new(post_params)
    banner.save!
    
    redirect_to admin_banners_path(banner), notice: '添加成功'
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    
    redirect_to admin_banners_path(@data), notice: '编辑成功'
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
  def find_data
    @data = Banner.find(params[:id])
  end
  
  def post_params
    params.require(:banner).permit!
  end
end
