class CreateAreas < ActiveRecord::Migration
  def change
    create_table "areas", force: true do |t|
      t.string  "code"
      t.string  "name"
      t.string  "parent_code"
      t.integer "parent_id"
      t.integer "lft",                        null: false
      t.integer "rgt",                        null: false
      t.integer "depth",          default: 0, null: false
      t.integer "children_count", default: 0, null: false
      t.integer "level"
      t.integer "position"
    end
  end
end
