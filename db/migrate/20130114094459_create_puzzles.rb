class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|
      t.string :theme
      t.string :name
      t.string :combo
      t.integer :power_reward
      t.integer :mana_reward
      t.integer :clue_cost_power
      t.integer :clue_cost_mana
      t.text :lore
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
