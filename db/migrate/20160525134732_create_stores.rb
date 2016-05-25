class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.references  :user
      t.references  :store_category
      t.string      :state
      t.integer     :position
      t.string      :logo
      t.string      :address
      t.string      :name
      t.string      :phone
      t.string      :desc
      t.text        :content
      t.timestamps
    end
  end
end
