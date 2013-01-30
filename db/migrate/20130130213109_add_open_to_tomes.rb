class AddOpenToTomes < ActiveRecord::Migration
  def change
    add_column :tomes, :open, :boolean
  end
end
