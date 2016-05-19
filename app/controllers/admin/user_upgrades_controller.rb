class Admin::UserUpgradesController < Admin::BaseController
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @upgrades = UserUpgrade.where(state: "create")
    @upgrades = @upgrades.page(params[:page]).per(100)
  end
  
  def edit
    @data = UserUpgrade.find(params[:id])
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
  
  private
  def find_data
    @data = UserUpgrade.find(params[:id])
  end
  
  def post_params
    params.require(:user_upgrade).permit!
  end
  
  
  
end
 