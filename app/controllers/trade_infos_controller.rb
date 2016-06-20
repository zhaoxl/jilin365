class TradeInfosController < AppBaseController
  def index
    @root_category = TradeInfoCategory.find(params[:rc]) rescue nil
    @sub_categories = @root_category.children rescue []
    @areas = cookies[:city_code].present? ? Area.where(parent_code: cookies[:city_code]) : []
    
    @trade_infos = TradeInfo.where(trade_info_category: @sub_categories) if params[:c].blank?
    @trade_infos = TradeInfo.where(trade_info_category_id: params[:c]) if params[:c].present?
    @trade_infos = @trade_infos.where(district_code: params[:a]) if params[:a].present?
    @trade_infos = @trade_infos.where("title LIKE ?", "%#{k}%") if params[:k].present?
    @trade_infos = @trade_infos.where(state: :payment)
  end
  
  def show
    TradeInfo.increment_counter(:look_count, params[:id])
    @trade_info = TradeInfo.where(state: :payment).find(params[:id]) rescue nil
    if @trade_info.blank?
      flash[:notice] = "信息不存在！"
      redirect_to index_index_path and return 
    end
    @collected = current_user.collects.where(item: @trade_info).exists?
    @similarity_trade_infos = TradeInfo.where(state: :payment).order("rand()").limit(3)
  end
  
  def like
    TradeInfo.increment_counter(:like_count, params[:id])
    redirect_to :back
  end
end
