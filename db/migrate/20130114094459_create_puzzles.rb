class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|
      t.string :theme
      t.string :name
      t.string :combo
      t.integer :power_reward
      t.integer :mana_reward
      t.text :lore
      t.string :clue_cost_schema
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
