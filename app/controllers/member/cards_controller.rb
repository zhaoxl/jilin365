class Member::CardsController < Member::BaseController
  def index
    category = params[:category] == "coupon" ? "0" : "1"
    @cards = Card.where(category: category)
  end
end
