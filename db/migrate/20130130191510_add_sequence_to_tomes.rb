class AddSequenceToTomes < ActiveRecord::Migration
  def change
    add_column :tomes, :sequence, :integer
  end
end
