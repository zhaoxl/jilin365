class CollectsController < AppBaseController
  def create
    if collect = current_user.collects.where(item_type: params[:t], item_id: params[:id]).first
      collect.destroy!
    else
      current_user.collects.build(item_type: params[:t], item_id: params[:id]).save
    end
    redirect_to :back
  end
end
