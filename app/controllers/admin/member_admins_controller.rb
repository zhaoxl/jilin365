class Admin::MemberAdminsController < Admin::BaseController
  authorize_resource :class => false
  
	
	def index
		@admins = Admin.joins("INNER JOIN admins_roles ON admins.id = admins_roles.admin_id").where("admins_roles.role_id!=1")
	end
  
  def edit
    @admin = Admin.find(params[:id])
    @roles = Role.all
  end
  
  def update
    admin = Admin.find(params[:id])
    admin.password = params[:password] if params[:password].present?
    admin.assign_attributes(post_param)
    admin.roles = Role.where(id: params[:role_ids].to_a.map(&:to_i))
    admin.save
    
    flash[:success] = "修改成功"
    
    redirect_to :back
  end
  
  def new
    @admin = Admin.new
    @roles = Role.all
  end
  
  def create
    @admin = Admin.new(post_param)
    unless @admin.save
      @instance = @admin
      render :new and return
    end
    
    @admin.roles = Role.where(id: params[:role_ids].to_a.map(&:to_i))
    @admin.save
    
    flash[:success] = "添加成功"
    
    redirect_to admin_member_admins_path
  end
  
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy!
    redirect_to :back, :notice => '操作成功!'
  end
  
  private
  def post_param
    params.require(:admin).permit!
  end
end
  
