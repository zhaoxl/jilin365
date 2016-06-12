class Member::StoresController < Member::BaseController
  def index
    @store = current_user.store || current_user.build_store
  end
  
  def create
    store = current_user.store || current_user.build_store
    store.assign_attributes(post_params)
    store.save
    flash[:notice] = "保存成功"
    redirect_to :back
  end
  
  private
  
  def post_params
    params.require(:store).permit!
  end
end
