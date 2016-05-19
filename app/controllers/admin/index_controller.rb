class Admin::IndexController < Admin::BaseController
  def index
  end
  
  def pwd
    
  end
  
  def pwd_save
    if current_admin.valid_password?(params[:password_old])
      if params[:password] == params[:password_confirm]
        current_admin.password = params[:password]
        current_admin.save
        flash[:success] = "修改成功，请重新登录"
      else
        flash[:notice] = "两次密码输入不一致"
      end
    else
      flash[:notice] = "原密码不正确"
    end
    
    redirect_to :back
  end

end