class CreateStoreImages < ActiveRecord::Migration
  def change
    create_table :store_images do |t|
      t.references  :user
      t.references  :store
      t.string      :image
      t.integer     :position
    end
  end
end
