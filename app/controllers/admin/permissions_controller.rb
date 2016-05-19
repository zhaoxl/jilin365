class Admin::PermissionsController < Admin::BaseController
  authorize_resource :class => false
  
  def index
    @permissions = Permission.all
  end
  
  def update
    permission = Permission.find(params[:id])
    permission.update_attribute(:name, params[:permission][:name])
    
    redirect_to :back
  end
  
  def destroy
    Permission.find(params[:id]).update_attribute(:hide, true)
    flash[:notice] = "隐藏成功!"
    redirect_to :back
  end
  
  def refresh
    Permission.refresh
    flash[:success] = "刷新成功!"
    
    redirect_to :back
  end
  
end
