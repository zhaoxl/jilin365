class Admin::CouponTemplatesController < Admin::BaseController
  authorize_resource :class => false
  
  before_action :find_data, except: [:index, :new, :create]
  
  def index
    @coupon_templates = CouponTemplate.all
  end
  
  def new
    @data = CouponTemplate.new
  end
  
  def create
    coupon_template = CouponTemplate.new(post_params)
    coupon_template.product_categories = ProductCategory.where(id: params[:categories])
    coupon_template.save!
    
    redirect_to admin_coupon_templates_path(coupon_template), notice: '添加成功'
  end
  
  def edit
    
  end
  
  def update
    @data.assign_attributes(post_params)
    @data.product_categories = ProductCategory.where(id: params[:categories])
    @data.save
    
    redirect_to admin_coupon_templates_path(@data), notice: '编辑成功'
  end
  
  def destroy
    redirect_to :back, notice: '模板已经使用，无法删除' and return if @data.coupons.present?
    @data.destroy!
    redirect_to :back, notice: '删除成功'
  end
  
  private
  def find_data
    @data = CouponTemplate.find(params[:id])
  end
  
  def post_params
    params.require(:coupon_template).permit!
  end
end
