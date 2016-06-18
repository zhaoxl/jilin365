class TradeInfosController < AppBaseController
  def index
    @root_category = TradeInfoCategory.find(params[:rc]) rescue nil
    @sub_categories = @root_category.children rescue []
    @areas = []
    
    @trade_infos = TradeInfo.where(trade_info_category_id: params[:rc]) if params[:c].blank?
    @trade_infos = TradeInfo.where(trade_info_category_id: params[:rc]) if params[:c].present?
  end
  
  def show
    TradeInfo.increment_counter(:look_count, 1)
    @trade_info = TradeInfo.find(params[:id])
    @similarity_trade_infos = TradeInfo.all
    @collected = current_user.collects.where(item: @trade_info).exists?
  end
  
  def like
    TradeInfo.increment_counter(:like_count, 1)
    redirect_to :back
  end
end
