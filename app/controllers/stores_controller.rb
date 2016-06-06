class StoresController < ApplicationController
  def index
    @root_category = TradeInfoCategory.find(params[:rc]) rescue nil
    @stores = Store.all
  end
  
  def show
    @store = Store.find(params[:id])
  end
end
