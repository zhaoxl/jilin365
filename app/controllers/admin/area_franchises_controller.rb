class Admin::AreaFranchisesController < Admin::BaseController
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @franchises = AreaFranchise.where("")
    @franchises = @franchises.where(state: params[:state]) if params[:state].present?
    @franchises = @franchises.page(params[:page]).per(100)
  end
  
  def new
    @data = AreaFranchise.new
  end
  
  def show
    params[:date_diff] ||= "#{Date.today.at_beginning_of_month} - #{Date.today.at_end_of_month}"
    
    @franchise = AreaFranchise.find(params[:id])
    @area = @franchise.area
    @page_title = @area.try(:fullname).presence
    @all_orders = Order.where("receiver_address_province_code = ? OR receiver_address_city_code = ? OR receiver_address_street_code = ?", @area.code, @area.code, @area.code).includes(:user)
        
    start_at = Date.strptime(params[:date_diff].split(' - ')[0])
    end_at = Date.strptime(params[:date_diff].split(' - ')[1])
    @current_orders = @all_orders.where("TO_DAYS(orders.created_at) >= TO_DAYS(?)", start_at).where("TO_DAYS(orders.created_at) <= TO_DAYS(?)", end_at)
    @current_orders = @current_orders.where("orders.scode LIKE ?", "%#{params[:scode]}%") if params[:scode].present?
    @current_orders = @current_orders.where("orders.state=?", params[:state]) if params[:state].present?
    @current_orders = @current_orders.joins("INNER JOIN users ON orders.user_id=users.id").where("users.name LIKE ?", "%#{params[:user_name]}%") if params[:user_name].present?
  end
  
  def create
    area_franchise = AreaFranchise.new(post_params)
    begin
      ActiveRecord::Base.transaction do
      area_franchise.save!
      flash[:success] = "添加成功"
      end
    rescue ActiveRecord::RecordInvalid
      flash[:error] = area_franchise.errors.messages.values.flatten[0]
    end
    redirect_to :back and return
  end
  
  def edit
    @data = AreaFranchise.find(params[:id])
  end
  
  def update
    begin
      @data.update_attributes!(post_params)
      flash[:success] = "编辑成功"

    rescue ActiveRecord::RecordInvalid
      flash[:error] = @data.errors.messages.values.flatten[0]
    end
    redirect_to :back 
  end
  
  private
  def find_data
    @data = AreaFranchise.find(params[:id])
  end
  
  def post_params
    params.require(:area_franchise).permit!
  end
  
  
  
end
 