class Member::CollectsController < Member::BaseController
  def index
    type = params[:type] == "info" ? "TradeInfo" : "Store"
    @collects = current_user.collects.where(item_type: type)
  end
  
  def delete
    @data = current_user.collects.find(params[:id])
    @data.destroy!
    flash[:notice] = "删除成功！"
    redirect_to :back
  end
end
