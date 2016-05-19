class Admin::DistributionSettingsController < Admin::BaseController
  authorize_resource :class => false
  
  def index
    @data = DistributionSetting.find_or_create_by({})
  end
  
  def update
    @data = DistributionSetting.find_or_create_by({})
    @data.update_attributes(post_params)
    flash[:success] = "保存成功"
    
    redirect_to :back
  end
  
  
  
  private
  
  def post_params
    params.require(:distribution_setting).permit!
  end
end
