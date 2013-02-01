class AddChapterToTome < ActiveRecord::Migration
  def change
    add_column :tomes, :chapter, :integer, :default=> '1'
  end
end
