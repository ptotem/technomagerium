class AddSequenceToPuzzles < ActiveRecord::Migration
  def change
    add_column :puzzles, :sequence, :integer
  end
end
