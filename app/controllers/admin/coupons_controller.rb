class Admin::CouponsController < Admin::BaseController
  authorize_resource :class => false
  
  before_action :find_data, except: [:index, :new, :create]
  
  def index
    @coupons = Coupon.all
  end
  
  def new
    @data = Coupon.new
  end
  
  def create
    coupon = Coupon.new(post_params)
    coupon.save!
    
    redirect_to admin_coupons_path(coupon), notice: '添加成功'
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    
    redirect_to admin_coupons_path(@data), notice: '编辑成功'
  end
  
  def destroy
    redirect_to :back, notice: '已经使用，无法删除' and return if @data.state != "create"
    @data.destroy!
    redirect_to :back, notice: '删除成功'
  end
  
  private
  def find_data
    @data = Coupon.find(params[:id])
  end
  
  def post_params
    params.require(:coupon).permit!
  end
end
