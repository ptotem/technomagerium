class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :puzzle_id
      t.boolean :lore
      t.boolean :counter
      t.boolean :revelation
      t.boolean :solved

      t.timestamps
    end
  end
end
