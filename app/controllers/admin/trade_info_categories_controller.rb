class Admin::TradeInfoCategoriesController < Admin::BaseController
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @datas = TradeInfoCategory.roots
  end
  
  def edit
    @data = TradeInfoCategory.find(params[:id])
  end
  
  def new
    @data = TradeInfoCategory.new
  end
  
  def create
    data = TradeInfoCategory.new(post_params)
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
  
  def users
    @users = @data.team_users
    @team_user = TradeInfoCategoryUser.new(team: @data)
  end
  
  private
  def find_data
    @data = TradeInfoCategory.find(params[:id])
  end
  
  def post_params
    params.require(:trade_info_category).permit!
  end
  
  
  
end