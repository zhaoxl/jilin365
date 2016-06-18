class AreasController < ApplicationController
  def index
    #吉林省
    @cities = Area.find(607).children.order("pinyin ASC").select("*, LEFT(pinyin, 1) AS i").group_by{|city| city.i}
  end
  
  def use
    cookies[:city_code] = params[:code]
    cookies[:city_name] = params[:name]
    
    redirect_to index_index_path
  end
  
end
