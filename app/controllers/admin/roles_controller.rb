class Admin::RolesController < Admin::BaseController
  authorize_resource :class => false
  
  def index
    @roles = Role.all
  end
  
  def new
    @role = Role.new
  end
  
  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to admin_roles_path, :notice => '操作成功!'
    else
      @instance = @role
			render :new
    end
  end
  
  def edit
    @role = Role.find(params[:id])
  end
  
  def update
    @role = Role.find(params[:id])
		if @role.update_attributes(role_params)
			redirect_to admin_roles_path, :notice => '操作成功!'
		else
			@instance = @role
			render :edit
		end
  end
  
  def destroy
    @role = Role.find(params[:id])
    @role.destroy!
    redirect_to admin_roles_path, :notice => '操作成功!'
  end
  
  def edit_permissions
    @role = Role.find(params[:id])
    @role_permissions = @role.permissions.map{|item| [item.parent_id, item.name]}
  end
  
  def update_permissions
    @role = Role.find(params[:id])
    pers = params[:permissions].map{|item| item.split("_") }.map{|item| "(parent_id=#{item[0]} AND name='#{item[1]}')"}.join(" or ")
    @role.permissions.delete_all
    @role.permissions << Permission.where(pers)
    redirect_to :back, notice: "操作成功"
  end
  
  private
  def role_params
      params.require(:role).permit!
  end
  
end
