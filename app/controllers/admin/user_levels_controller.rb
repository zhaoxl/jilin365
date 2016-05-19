class Admin::UserLevelsController < Admin::BaseController
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @user_levels = UserLevel.where("")
    @user_levels = @user_levels.where(state: params[:state]) if params[:state].present?
    @user_levels = @user_levels.where(parent_id: params[:parent_id])
    @user_levels = @user_levels.page(params[:page]).per(100)
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    flash[:success] = "编辑成功"
    
    redirect_to :back 
  end
  
  def create
    levels = params[:user_level]
    was_levels = UserLevel.all
    was_levels.each do |ulevel|
      ulevel.update_attributes(levels[ulevel[:id].to_s].permit!)
    end
    flash[:success] = "编辑成功"
    
    redirect_to :back
  end
  
  private
  def find_data
    @data = UserLevel.find(params[:id])
  end
  
  def post_params
    params.require(:user_level).permit!
  end
  
  
  
end
 