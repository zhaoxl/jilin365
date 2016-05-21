class CreateTradeInfoCategories < ActiveRecord::Migration
  def change
    create_table :trade_info_categories do |t|
      t.string  :name
      t.string  :logo
      t.integer :position
      
      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true

      # optional fields
      t.integer :depth, :null => false, :default => 0
      t.integer :children_count, :null => false, :default => 0
    end
  end
end
