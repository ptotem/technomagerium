class CreateEncyclopediaEntries < ActiveRecord::Migration
  def change
    create_table :encyclopedia_entries do |t|
      t.integer :puzzle_id
      t.integer :attack
      t.integer :defense
      t.integer :magic
      t.integer :speed
      t.text :description

      t.timestamps
    end
  end
end
