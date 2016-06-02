class IndexController < ApplicationController
  def index
    @trade_categories = TradeInfoCategory.roots.limit(8)
    @recommend_infos = TradeInfo.where(recommend: true).order("position ASC").limit(5)
  end
end
