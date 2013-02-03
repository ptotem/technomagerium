class AddBookmarkToUserState < ActiveRecord::Migration
  def change
    add_column :user_states, :bookmark, :integer
  end
end
