class Admin::StoreCategoriesController < Admin::BaseController
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @datas = StoreCategory.all
  end
  
  def edit
    @data = StoreCategory.find(params[:id])
  end
  
  def new
    @data = StoreCategory.new
  end
  
  def create
    data = StoreCategory.new(post_params)
    data.save
    flash[:success] = "添加成功"
    
    redirect_to :back 
  end
  
  def update
    begin
      case params[:act]
      when "pass" then
        @data.set_state_pass!
      when "reject" then
        @data.set_state_reject!
      end
      @data.update_attributes!(post_params)
      flash[:success] = "编辑成功"

    rescue ActiveRecord::RecordInvalid
      flash[:error] = @data.errors.messages.values.flatten[0]
    end
    redirect_to :back 
  end
  
  private
  def find_data
    @data = StoreCategory.find(params[:id])
  end
  
  def post_params
    params.require(:store_category).permit!
  end
  
  
  
end