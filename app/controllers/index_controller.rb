class IndexController < ApplicationController
  def index
    #如果用户地区丢失自动设置为长春
    cookies[:city_code] = "220100" if cookies[:city_code].blank?
    cookies[:city_name] = "长春市" if cookies[:city_code].blank?
    
    @trade_categories = TradeInfoCategory.roots.limit(8)
    @recommend_infos = TradeInfo.where(state: :payment).where(recommend: true).where(city_code: cookies[:city_cpde]).order("position ASC").limit(5)
  end
end
