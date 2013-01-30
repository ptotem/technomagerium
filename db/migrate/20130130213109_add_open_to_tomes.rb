class AddOpenToTomes < ActiveRecord::Migration
  def change
    add_column :tomes, :openable, :boolean
  end
end
