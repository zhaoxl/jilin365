class Member::CollectsController < Member::BaseController
  def index
    type = params[:type] == "info" ? "TradeInfo" : "Store"
    @collects = Collect.where(item_type: type)
  end
end
