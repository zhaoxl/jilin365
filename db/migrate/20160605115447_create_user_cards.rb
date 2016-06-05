class CreateUserCards < ActiveRecord::Migration
  def change
    create_table :user_cards do |t|
      t.references  :card
      t.references  :user
      t.timestamps
    end
  end
end
