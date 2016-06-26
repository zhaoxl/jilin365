class Member::CardsController < Member::BaseController
  def index
    category = params[:category]
    @cards = current_user.store.cards.where(category: category).order("id DESC")
  end
  
  def new
    @card = current_user.store.cards.build(category: Card.categories.find{|c| c[1]==params[:category].to_i}[0])
  end
  
  def create
    card = current_user.store.cards.build(user_id: current_user.id, store_id: current_user.store.id)
    card.assign_attributes(post_params)
    card.begin_at = Time.now
    card.save
    flash[:notice] = "添加成功"
    redirect_to member_cards_path(category: Card.categories[card.category].to_i)
  end
  
  def edit
    @card = current_user.store.cards.find(params[:id])
  end
  
  def update
    card = current_user.store.cards.find(params[:id])
    card.assign_attributes(post_params)
    card.save
    flash[:notice] = "编辑成功"
    redirect_to member_cards_path(category: Card.categories[card.category].to_i)
  end
  
  def delete
    card = current_user.store.cards.find(params[:id])
    card.destroy!
    flash[:notice] = "删除成功！"
    redirect_to :back
  end
  
  
  private  
  def post_params
    params.require(:card).permit!
  end
end
