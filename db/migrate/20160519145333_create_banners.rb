class CreateBanners < ActiveRecord::Migration
  def change
    create_table "banners", force: true do |t|
      t.string   "title"
      t.string   "description"
      t.string   "url",         limit: 500
      t.string   "image"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
