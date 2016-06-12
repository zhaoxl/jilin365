class Admin::TradeInfoAttrsController < Admin::BaseController
  # authorize_resource :class => false
  
  before_action :find_trade_info
  
  def index
    @datas = @trade_info.trade_info_attrs
  end
  
  def updates
    # params["attrs"].keys.each do |attr|
#       info_attr = @trade_info.trade_info_attrs.find{|ir| ir.name == attr[0]} || @trade_info.trade_info_attrs.build(name:)
#     end
#     @datas = @trade_info.trade_info_attrs
#     @datas.each do |attr|
#       attr.update_attribute(:value, params["attrs"][attr.name])
#     end

    #删除没用的属性
    @trade_info.trade_info_attrs.where.not(name: params[:attrs].map{|attr| attr["attr_name"]}).delete_all
    #更新新属性
    params[:attrs].each do |attr|
      info_attr = @trade_info.trade_info_attrs.find{|ir| ir.trade_info_category_attr_id.to_i == attr[:attr_id].to_i} || @trade_info.trade_info_attrs.build(trade_info_category_attr_id: attr[:attr_id], name: attr[:attr_name])
      info_attr.value = attr[:attr_value]
      info_attr.data_type = attr[:data_type]
      info_attr.list_display = attr[:list_display] == "true"
      
      info_attr.save
    end
    flash[:notice] = "更新成功"
    
    redirect_to :back
  end
  
  private
  def find_trade_info
    @trade_info = TradeInfo.find(params[:trade_info_id])
  end
  
end
