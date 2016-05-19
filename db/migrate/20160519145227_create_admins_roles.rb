class CreateAdminsRoles < ActiveRecord::Migration
  def change
    create_table "admins_roles", id: false, force: true do |t|
      t.integer "admin_id"
      t.integer "role_id"
    end

    add_index "admins_roles", ["admin_id", "role_id"], name: "index_admins_roles_on_admin_id_and_role_id", using: :btree
  end
end
