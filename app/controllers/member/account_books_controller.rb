class Member::AccountBooksController < Member::BaseController
  def index
    @logs = current_user.user_account_books.where(category: params[:c]).order("id DESC")
  end
end
