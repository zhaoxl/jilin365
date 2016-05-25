class CreateSingleArticles < ActiveRecord::Migration
  def change
    create_table :single_articles do |t|
      t.string   "key"
      t.string   "title"
      t.text     "content"
      t.boolean  "can_delete", default: true
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
