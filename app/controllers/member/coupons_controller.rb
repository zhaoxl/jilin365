class Member::CouponsController < Member::BaseController
  def index
    @coupons = Coupon.where(user: current_user).order("state<>'create'")
  end
end
