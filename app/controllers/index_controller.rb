class IndexController < ApplicationController
  def index
    @trade_categories = TradeInfoCategory.roots.limit(8)
  end
end
