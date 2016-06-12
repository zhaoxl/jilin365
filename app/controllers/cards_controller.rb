class CardsController < AppBaseController
  def index
    @cards = Card.all
  end
  
  def show
    @card = Card.find(params[:id])
    @received = current_user.user_cards.where(card: @card).exists?
  end
end
