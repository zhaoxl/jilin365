class Admin::AreasController < Admin::BaseController
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @areas = Area.where("")
    @areas = @areas.where(state: params[:state]) if params[:state].present?
    @areas = @areas.where(parent_id: params[:parent_id])
    @areas = @areas.page(params[:page]).per(100)
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
    @data = Area.find(params[:id])
  end
  
  def post_params
    params.require(:area).permit!
  end
  
  
  
end
 