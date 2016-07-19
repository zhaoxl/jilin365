class CreateTradeInfoUserLikes < ActiveRecord::Migration
  def change
    create_table :trade_info_user_likes do |t|
      t.references  :trade_info
      t.references  :user
      t.timestamps
    end
  end
end
