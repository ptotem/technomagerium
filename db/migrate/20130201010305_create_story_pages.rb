class CreateStoryPages < ActiveRecord::Migration
  def change
    create_table :story_pages do |t|
      t.integer :user_id
      t.integer :num
      t.text :progress

      t.timestamps
    end
  end
end
