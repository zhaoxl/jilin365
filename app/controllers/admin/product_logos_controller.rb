class Admin::ProductLogosController < Admin::BaseController
  authorize_resource :class => false
  
  before_action :find_product
  before_action :find_data, except: [:index, :new, :create]
  
  def index
    @logos = @product.product_logos
  end
  
  def new
    @logo = @product.product_logos.build
  end
  
  def create
    logo = @product.product_logos.build(post_params)
    logo.save!
    
    redirect_to admin_product_product_logos_path(@product), notice: '添加成功'
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    
    redirect_to admin_product_product_logos_path(@product), notice: '编辑成功'
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
  def find_product
    @product = Product.find(params[:product_id])
  end
  
  def find_data
    @data = ProductLogo.find(params[:id])
  end
  
  def post_params
    params.require(:product_logo).permit!
  end
end
