class CreateCollects < ActiveRecord::Migration
  def change
    create_table :collects do |t|
      t.references  :user
      t.string      :item_type
      t.integer     :item_id
      t.timestamps
    end
  end
end
