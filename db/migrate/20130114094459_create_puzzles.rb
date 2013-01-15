class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|
      t.string :theme
      t.string :name
      t.text :writeup
      t.string :combo

      t.timestamps
    end
  end
end
