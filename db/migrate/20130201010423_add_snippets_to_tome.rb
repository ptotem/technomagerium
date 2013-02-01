class AddSnippetsToTome < ActiveRecord::Migration
  def change
    add_column :tomes, :beginning, :text
    add_column :tomes, :ending, :text
  end
end
