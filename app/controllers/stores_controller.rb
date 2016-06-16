class StoresController < ApplicationController
  def index
    @category = StoreCategory.find(params[:c]) rescue nil
    @stores = Store.where("")
    @stores = @stores.where(store_category_id: @category.id) if @category.present?
  end
  
  def show
    @store = Store.find(params[:id])
  end
end
