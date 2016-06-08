class Member::UserUpgradesController < Member::BaseController
  
  def index
    @upgrades = UserUpgrade.where(parent_user_id: current_user, state: "create")
  end
  
  def new
    @avable_levels = UserLevel.where("level > ?", current_user.level)
  end
  
  def create
    if UserUpgrade.where(user: current_user, state: "create").count == 0
      user_upgrade = UserUpgrade.new(post_params)
      user_upgrade.user = current_user
      user_upgrade.old_level = current_user.level
      user_upgrade.parent_user_id = current_user.recommend_user_id
      user_upgrade.save
      flash[:notice] = '提交成功，请耐心等待审核结果'
    else
      flash[:notice] = '您的申请正在审核，请不要重复提交'
    end
    redirect_to new_member_user_upgrade_path
  end
  
  def pass
    user_upgrade = UserUpgrade.find(params[:id])
    user_upgrade.set_state_pass!
    redirect_to :back
  end
  
  def edit
    @user_upgrade = UserUpgrade.find(params[:id])
  end
  
  def update
    user_upgrade = UserUpgrade.find(params[:id])
    user_upgrade.set_state_reject
    user_upgrade.feedback = post_params[:feedback]
    user_upgrade.save
    
    redirect_to member_user_upgrades_path
  end
  
  def result
    @user_upgrade = UserUpgrade.where(user: current_user).last
  end
  
  private
  
  def post_params
    params.require(:user_upgrade).permit!
  end
end
