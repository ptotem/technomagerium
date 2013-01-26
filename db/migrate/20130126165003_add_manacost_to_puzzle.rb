class AddManacostToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :manacost, :boolean
  end
end
