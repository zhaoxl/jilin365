class TradeInfosController < AppBaseController
  def index
    @root_category = TradeInfoCategory.find(params[:rc]) rescue nil
    @trade_infos = TradeInfo.all
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
