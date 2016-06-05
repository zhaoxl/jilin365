class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references  :store
      t.integer     :category
      t.string      :name
      t.integer     :position
      t.string      :state
      t.string      :logo
      t.string      :phone
      t.string      :desc
      t.text        :content
      t.datetime    :begin_at
      t.datetime    :end_at
      t.integer     :count

      t.timestamps
    end
  end
end
