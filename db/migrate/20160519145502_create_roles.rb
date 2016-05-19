class CreateRoles < ActiveRecord::Migration
  def change
    create_table "roles", force: true do |t|
      t.string  "name"
      t.string  "state"
      t.string  "resource_type"
      t.integer "resource_id"
    end

    add_index "roles", ["name"], name: "index_roles_on_name", using: :btree, length: 100
    
  end
end
