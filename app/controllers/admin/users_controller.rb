class Admin::UsersController < Admin::BaseController
  authorize_resource :class => false
  
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @users = User.where("").includes(:distribution).includes(:wallet)
    @users = @users.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
    @users = @users.where(state: params[:state]) if params[:state].present?
    @users = @users.page(params[:page]).per(50)
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    flash[:success] = "编辑成功"
    
    redirect_to :back 
  end
  
  def lock_save
    @data.update_attributes(post_params)
    @data.set_state_temp_lock!
    flash[:success] = "锁定成功"
    
    redirect_to :back 
  end
  
  def unlock
    @data.set_state_create!
    flash[:success] = "解锁成功"
    
    redirect_to :back 
  end
  
  private
  def find_data
    @data = User.find(params[:id])
  end
  
  def post_params
    params.require(:user).permit!
  end
  
  
  
end
 