class Member::ProfileController < Member::BaseController
  def index
    
  end
  
  def update
    current_user.update_attributes(post_params)
    redirect_to member_root_path
  end
  
  private
  
  def post_params
    params.require(:user).permit(:truename, :phone, :province_code, :city_code, :street_code)
  end
end
