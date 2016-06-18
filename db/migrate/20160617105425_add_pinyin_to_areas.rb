class AddPinyinToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :pinyin, :string
  end
end
