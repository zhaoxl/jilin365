class Admin::TradeInfoCategoryAttrsController < Admin::BaseController
  # authorize_resource :class => false
  
  before_action :find_trade_info_category
  before_action :find_data, except: [:index, :new, :create]
  
  def index
    @datas = @trade_info_category.trade_info_category_attrs
  end
  
  def new
    @data = @trade_info_category.trade_info_category_attrs.build
  end
  
  def create
    @data = @trade_info_category.trade_info_category_attrs.build(post_params)
    @data.save!
    
    redirect_to admin_trade_info_category_trade_info_category_attrs_path(@trade_info_category), notice: '添加成功'
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    
    redirect_to admin_trade_info_category_trade_info_category_attrs_path(@trade_info_category), notice: '编辑成功'
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
  def find_trade_info_category
    @trade_info_category = TradeInfoCategory.find(params[:trade_info_category_id])
  end
  
  def find_data
    @data = TradeInfoCategoryAttr.find(params[:id])
  end
  
  def post_params
    params.require(:trade_info_category_attr).permit!
  end
end
