class Member::IndexController < Member::BaseController
  def index
    redirect_to member_profile_index_path and return if current_user.phone.blank? || current_user.truename.blank?
  end
end
