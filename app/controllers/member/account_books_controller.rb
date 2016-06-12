class Member::AccountBooksController < Member::BaseController
  def index
    @logs = current_user.account_books.where(category: params[:category])
  end
  
  def income_logs
    
  end
end
