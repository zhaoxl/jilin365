class Member::UserCardsController < Member::BaseController
  def index
    category = params[:category]
    @cards = Card.where(category: category)
  end
end
