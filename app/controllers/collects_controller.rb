class CollectsController < AppBaseController
  def create
    if collect = current_user.collects.where(item_type: params[:t], item_id: params[:id]).first
      collect.destroy!
      flash[:notice] = "取消收藏成功！"
    else
      current_user.collects.build(item_type: params[:t], item_id: params[:id]).save
      flash[:notice] = "收藏成功！"
    end
    redirect_to :back
  end
end
