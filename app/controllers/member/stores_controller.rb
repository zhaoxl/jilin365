class Member::StoresController < Member::BaseController
  def index
    @store = current_user.store || current_user.build_store
  end
  
  def create
    store = current_user.store || current_user.build_store
    store.assign_attributes(post_params)
    store.save
    #所有暂存图片转入本条消息
    StoreImage.where(user: current_user).where(store_id: nil).update_all({store_id: store.id})
    
    flash[:notice] = "保存成功"
    redirect_to :back
  end
  
  def upload_image
    @images = []
    info = current_user.store rescue nil
    
    @images << StoreImage.where(store: info) if info.present?
    @images << StoreImage.where("store_id IS NULL AND user_id=?", current_user.id)
    @images.flatten!
    
    render layout: false
  end
  
  def upload_image_save
    info = current_user.store rescue nil
    image = StoreImage.new(user: current_user, image: params[:file], store: info)
    image.save
    
    redirect_to :back
  end
  
  def upload_image_destroy
    StoreImage.where(user: current_user).find(params[:image]).destroy!
    redirect_to :back
  end
  
  
  private
  
  def post_params
    params.require(:store).permit!
  end
end
