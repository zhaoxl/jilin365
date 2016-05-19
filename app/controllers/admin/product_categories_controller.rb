class Admin::ProductCategoriesController < Admin::BaseController
  authorize_resource :class => false
  
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @categories = ProductCategory.roots
  end
  
  def new
    @category = ProductCategory.new
  end
  
  def create
    category = ProductCategory.new(post_params)
    category.save
    flash[:success] = "添加成功"
    
    redirect_to :back 
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    flash[:success] = "编辑成功"
    
    redirect_to :back 
  end
  
  def move_down
    @data.move_lower
    redirect_to :back
  end
  
  def move_up
    @data.move_higher
    redirect_to :back
  end
  
  def destroy
    @data.destroy!
    redirect_to :back
  end
  
  private
  def find_data
    @data = ProductCategory.find(params[:id])
  end
  
  def post_params
    params.require(:product_category).permit!
  end
  
  
  
end
 