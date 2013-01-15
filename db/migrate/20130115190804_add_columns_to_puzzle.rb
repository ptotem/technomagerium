class AddColumnsToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :power, :integer
    add_column :puzzles, :mana, :integer
  end
end
