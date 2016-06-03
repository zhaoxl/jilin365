class Admin::TradeInfoAttrsController < Admin::BaseController
  # authorize_resource :class => false
  
  before_action :find_trade_info
  before_action :find_data, except: [:index, :new, :create]
  
  def index
    @datas = @trade_info.trade_info_attrs
  end
  
  def updates
    @datas = @trade_info.trade_info_attrs
  end
  
  private
  def find_trade_info
    @trade_info = TradeInfo.find(params[:trade_info_id])
  end
  
  def find_data
    @data = TradeInfoAttr.find(params[:id])
  end
  
  def post_params
    params.require(:trade_info_attr).permit!
  end
end
