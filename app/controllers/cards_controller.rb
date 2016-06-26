class CardsController < AppBaseController
  def index
    @cards = Card.order("id DESC")
    @cards = @cards.where(store_id: params[:s]) if params[:s].present?
  end
  
  def show
    @card = Card.find(params[:id])
    @received = current_user.user_cards.where(card: @card).exists?
  end
end
