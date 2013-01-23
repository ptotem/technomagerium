class AddTomeIdToPuzzles < ActiveRecord::Migration
  def change
    add_column :puzzles, :tome_id, :integer
  end
end
