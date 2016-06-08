class Member::AreaFranchisesController < Member::BaseController
  def create
    af = AreaFranchise.new(post_params)
    af.user = current_user
    af.save
    flash[:notice] = "提交成功， 请等待后台审核"
    
    redirect_to :back
  end
  
  
  private  
  def post_params
    params.require(:area_franchise).permit!
  end
  
end
