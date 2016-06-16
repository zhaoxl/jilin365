class Member::CardsController < Member::BaseController
  def index
    category = params[:category]
    @cards = Card.where(category: category)
  end
end
