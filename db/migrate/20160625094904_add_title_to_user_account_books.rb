class AddTitleToUserAccountBooks < ActiveRecord::Migration
  def change
    add_column :user_account_books, :title, :string
  end
end
