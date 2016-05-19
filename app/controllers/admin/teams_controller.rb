class Admin::TeamsController < Admin::BaseController
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @teams = Team.where("")
    @teams = @teams.where(state: params[:state]) if params[:state].present?
    @teams = @teams.page(params[:page]).per(100)
  end
  
  def edit
    @data = Team.find(params[:id])
  end
  
  def update
    begin
      case params[:act]
      when "pass" then
        @data.set_state_pass!
      when "reject" then
        @data.set_state_reject!
      end
      @data.update_attributes!(post_params)
      flash[:success] = "编辑成功"

    rescue ActiveRecord::RecordInvalid
      flash[:error] = @data.errors.messages.values.flatten[0]
    end
    redirect_to :back 
  end
  
  def users
    @users = @data.team_users
    @team_user = TeamUser.new(team: @data)
  end
  
  def add_user
    if TeamUser.where(user_id: user_post_params[:user_id], state: :pass).exists?
      flash[:notice] = "该用户已加入其他团队"
      redirect_to :back and return
    end
    
    unless team_user = @data.team_users.where(user_id: user_post_params[:user_id]).first
      team_user = @data.team_users.build(user_post_params)
    end
    team_user.save

    flash[:success] = "添加成功"
    redirect_to :back 
  end
  
  def destroy_user
    @data.team_users.find(params[:team_user_id]).destroy!

    flash[:success] = "删除成功"
    redirect_to :back 
  end
  
  private
  def find_data
    @data = Team.find(params[:id])
  end
  
  def post_params
    params.require(:team).permit!
  end
  
  def user_post_params
    params.require(:team_user).permit!
  end
  
  
  
end