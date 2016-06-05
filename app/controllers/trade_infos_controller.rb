class TradeInfosController < ApplicationController
  def index
    @root_category = TradeInfoCategory.find(params[:rc]) rescue nil
    @trade_infos = TradeInfo.all
  end
  
  def show
    @trade_info = TradeInfo.find(params[:id])
    @similarity_trade_infos = TradeInfo.all
  end
end
