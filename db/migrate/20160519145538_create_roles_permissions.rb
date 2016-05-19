class CreateRolesPermissions < ActiveRecord::Migration
  def change
    create_table "roles_permissions", force: true do |t|
      t.integer "role_id"
      t.integer "permission_id"
    end
  end
end
