class Admin::BaseController < ActionController::Base
	layout "admin"
  before_action :authenticate_admin!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied, :with => :access_denied_render
  
  #protected####################################################
  protected
  
  def access_denied_render
    flash[:error] = "您没有操作权限"
    redirect_to admin_index_index_path and return
  end

  def configure_permitted_parameters
    # binding.pry
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit({ roles: [] }, :email, :password, :remember_me, :authentication_token) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :authentication_token) }
  end
  
  def get_cookie_id
    return cookies.permanent[:cookie_id] ||= SecureRandom.uuid
  end

	def current_ability
		@current_ability ||= Ability.new(current_admin)
	end  
  
end