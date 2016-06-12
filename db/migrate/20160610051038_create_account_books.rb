class CreateAccountBooks < ActiveRecord::Migration
  def change
    create_table :account_books do |t|
      t.references  :user
      t.string      :category
      t.string      :item_type
      t.integer     :item_id
      t.string      :title
      t.string      :remark, limit: 1000
      t.timestamps
    end
  end
end
