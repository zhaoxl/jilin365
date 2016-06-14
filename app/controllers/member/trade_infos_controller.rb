class Member::TradeInfosController < Member::BaseController
  
  def index
    @infos = current_user.trade_infos.order("id DESC")
  end
  
  def new_category
    
  end
  
  def new
    @trade_info = TradeInfo.new
    @category = TradeInfoCategory.find(params[:c])
    @attrs = @category.try(:trade_info_category_attrs)
  end
  
  def create
    category = TradeInfoCategory.find(params[:c])
    
    info = current_user.trade_infos.build(title: params[:title], desc: params[:desc], price: params[:price], content: params[:content])
    info.expired_at = Time.now +  params[:day].to_i.days
    info.total_fee = params[:day].to_i * category.price
    
    (params[:attrs]||[]).each do |attr|
      info.trade_info_attrs << info.trade_info_attrs.build(
        trade_info_category_attr_id: attr[:attr_id], 
        name: attr[:attr_name],
        value: attr[:attr_value],
        data_type: attr[:data_type],
        list_display: attr[:list_display] == "true"
      )
    end
    info.save
    flash[:notice] = "添加成功"
    redirect_to :back
  end
  
end