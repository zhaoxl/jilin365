class UserCardsController < AppBaseController
  def create
    unless current_user.collects.where(item_type: params[:t], item_id: params[:id]).exists?
      card = Card.find(params[:id])
      if card.count.to_i > 0
        current_user.user_cards.build(card: card).save
        card.count -=1
        card.save
      else
        flash[:notice] = "数量不足，领取失败"
      end
    end
    redirect_to :back
  end
end
