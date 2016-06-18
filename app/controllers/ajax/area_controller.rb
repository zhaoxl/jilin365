class Ajax::AreaController < ApplicationController
  def children
    render json: Area.where(parent_code: params[:code]).map{|area| {name: area.name, code: area.code}}.to_json
  end
end
