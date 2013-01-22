class AddRevealedToGames < ActiveRecord::Migration
  def change
    add_column :games, :revealed, :string
  end
end
