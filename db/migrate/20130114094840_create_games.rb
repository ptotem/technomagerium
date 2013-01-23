class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :puzzle_id
      t.boolean :lore, :default=>false
      t.boolean :counter, :default=>false
      t.boolean :revelation, :default=>false
      t.boolean :solved, :default=>false

      t.timestamps
    end
  end
end
