class Admin::DistributionsController < Admin::BaseController
  authorize_resource :class => false
  
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @distributions = Distribution.where("")
    @distributions = @distributions.where(state: params[:state]) if params[:state].present?
    @distributions = @distributions.page(params[:page]).per(100)
  end
  
  def show
    @data = Distribution.find(params[:id])
    @logs = DividendLog.where(recommend_user_id: params[:user_id]).order("created_at DESC")
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    flash[:success] = "编辑成功"
    
    redirect_to :back 
  end
  
  private
  def find_data
    @data = Distribution.find(params[:id])
  end
  
  def post_params
    params.require(:distribution).permit!
  end
  
  
  
end
 