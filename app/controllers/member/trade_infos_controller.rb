class Member::TradeInfosController < Member::BaseController
  
  def index
    @infos = current_user.trade_infos.order("id DESC")
  end
  
  def new_category
    current_user
    
  end
  
  def new
    current_user
    
    @trade_info = TradeInfo.new
    @category = TradeInfoCategory.find(params[:c])
    @attrs = @category.try(:trade_info_category_attrs)
  end
  
  def create
    category = TradeInfoCategory.find(params[:c])
    
    info = current_user.trade_infos.build(title: post_params[:title], desc: post_params[:desc], price: post_params[:price], content: post_params[:content], trade_info_category: category)
    info.expired_at = Time.now +  params[:day].to_i.days
    info.total_fee = params[:day].to_i * category.price.to_f
    
    (params[:attrs]||[]).each do |attr|
      info.trade_info_attrs << info.trade_info_attrs.build(
        trade_info_category_attr_id: attr[:attr_id], 
        name: attr[:attr_name],
        value: attr[:value],
        data_type: attr[:data_type],
        list_display: attr[:list_display] == "true"
      )
    end
    info.save
    #所有暂存图片转入本条消息
    TradeInfoImage.where(user: current_user).where(trade_info_id: nil).update_all({trade_info_id: info.id})
    flash[:notice] = "发布成功"
    redirect_to member_trade_infos_path
  end
  
  def edit
    @trade_info = current_user.trade_infos.find(params[:id])
    @category = @trade_info.trade_info_category
    @attrs = @category.try(:trade_info_category_attrs)
    @info_attrs = @trade_info.trade_info_attrs
  end
  
  def update
    info = current_user.trade_infos.find(params[:id])
    info.title = post_params[:title]
    info.desc = post_params[:desc]
    info.price = post_params[:price]
    info.content = post_params[:content]
    info.city_code = post_params[:city_code]
    info.district_code = post_params[:district_code]
    
    (params[:attrs]||[]).each do |attr|
      info_attr = info.trade_info_attrs.find_or_initialize_by(
        trade_info_category_attr_id: attr[:attr_id],
        name: attr[:attr_name]
      )
      info_attr.value = attr[:value]
      info_attr.data_type = attr[:data_type]
      info_attr.list_display = attr[:list_display] == "true"
      info_attr.save
    end
    info.save
    #所有暂存图片转入本条消息
    TradeInfoImage.where(user: current_user).where(trade_info_id: nil).update_all({trade_info_id: info.id})
    
    flash[:notice] = "修改成功"
    redirect_to member_trade_infos_path
  end
  
  def delete
    @trade_info = current_user.trade_infos.find(params[:id])
    @trade_info.destroy!
    flash[:notice] = "删除成功"
    redirect_to :back
  end
  
  def upload_image
    @images = []
    info = current_user.trade_infos.find(params[:id]) rescue nil
    
    @images << TradeInfoImage.where(trade_info: info) if info.present?
    @images << TradeInfoImage.where("trade_info_id IS NULL AND user_id=?", current_user.id)
    @images.flatten!
    
    render layout: false
  end
  
  def upload_image_save
    info = current_user.trade_infos.find(params[:id]) rescue nil
    image = TradeInfoImage.new(user: current_user, image: params[:file], trade_info: info)
    image.save
    
    redirect_to :back
  end
  
  def upload_image_destroy
    
      TradeInfoImage.where(user: current_user).find(params[:image]).destroy!

    
    redirect_to :back
  end
  
  
  private  
  def post_params
    params.require(:trade_info).permit!
  end
  
  
end