class IndexController < AppBaseController
  layout false
  
  def index
    #如果用户地区丢失自动设置为长春
    cookies[:city_code] = "220100" if cookies[:city_code].blank? || cookies[:city_name].blank?
    cookies[:city_name] = "长春市" if cookies[:city_code].blank?|| cookies[:city_name].blank?
    
    @trade_categories = TradeInfoCategory.roots.limit(8)
    @recommend_infos = TradeInfo.where(state: :payment).where(recommend: true).where(city_code: cookies[:city_code]).order("like_count desc, created_at desc").limit(5)
  end
end
