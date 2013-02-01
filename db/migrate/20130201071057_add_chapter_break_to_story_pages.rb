class AddChapterBreakToStoryPages < ActiveRecord::Migration
  def change
    add_column :story_pages, :chapter_break, :boolean, :default=>false
  end
end
