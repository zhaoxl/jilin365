class Member::TradeInfosController < Member::BaseController
  def new
    @trade_info = TradeInfo.new
    @category = TradeInfoCategory.find(params[:cid])
    @attrs = @category.try(:trade_info_category_attrs)
  end
end
