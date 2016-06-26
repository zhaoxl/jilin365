class AddDeletedAtToCards < ActiveRecord::Migration
  def change
    add_column :cards, :deleted_at, :datetime
    add_index :cards, :deleted_at
  end
end
