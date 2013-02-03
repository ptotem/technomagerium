class AddBookmarkToUserStatus < ActiveRecord::Migration
  def change
    add_column :user_statuses, :bookmark, :integer
  end
end
