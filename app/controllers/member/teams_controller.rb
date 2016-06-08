class Member::TeamsController < Member::BaseController
  def index
    redirect_to member_index_index_path and return unless @team = current_user.team
  end
  
  def users
    redirect_to member_index_index_path and return unless @team = current_user.team
  end
  
  def create
    if Team.where(leader_user_id: current_user.id, state: "create").count == 0
      team = Team.new(post_params)
      team.leader_user_id = current_user.id
      team.save
      flash[:notice] = '提交成功，请耐心等待审核结果'
    else
      flash[:notice] = '您的申请正在审核，请不要重复提交'
    end
    redirect_to new_member_team_path
  end
  
  def destroy_user
    if team = Team.where(leader_user_id: current_user.id).first
      team.team_users.where(user_id: params[:user_id]).destroy_all
    end
    
    redirect_to :back
  end
  
  def invote_user
    unless team = Team.where(leader_user_id: current_user.id).first
      flash[:notice] = "您还没有自己的团队，不可以邀请"
      redirect_to :back and return
    end
    if team.state != "pass"
      flash[:notice] = "您的团队状态不可以邀请"
      redirect_to :back and return
    end
  end
  
  def invote_user_save
    unless team = Team.where(leader_user_id: current_user.id).first
      flash[:notice] = "您还没有自己的团队，不可以邀请"
      redirect_to :back and return
    end
    if team.state != "pass"
      flash[:notice] = "您的团队状态不可以邀请"
      redirect_to :back and return
    end
    unless user = User.where(id: params[:user_id]).first
      flash[:notice] = "用户不存在"
      redirect_to :back and return
    end
    if user.id == current_user.id
      flash[:notice] = "不能邀请自己"
      redirect_to :back and return
    end
    if TeamUser.where(user_id: user.id, state: :pass).exists?
      flash[:notice] = "该用户已加入其他团队"
      redirect_to :back and return
    end
    if team.team_users.where(user_id: user.id).exists?
      flash[:notice] = "该用户已经在您的团队中"
      redirect_to :back and return
    end
    team_user = team.team_users.build(user: user)
    team_user.save

    flash[:notice] = "邀请成功"
    redirect_to member_teams_path
  end
  
  def invotes_pass
    if team = TeamUser.where(id: params[:team_user_id], user_id: current_user.id).first
      team.set_state_pass!
    end
    
    redirect_to member_index_index_path
  end
  
  def invotes_reject
    if team = TeamUser.where(id: params[:team_user_id], user_id: current_user.id).first
      team.set_state_reject!
    end
    
    redirect_to member_index_index_path
  end

  
  private
  
  def post_params
    params.require(:team).permit!
  end
  
  
end
