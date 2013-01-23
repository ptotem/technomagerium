class CreateTomes < ActiveRecord::Migration
  def change
    create_table :tomes do |t|
      t.string :name
      t.integer :completed

      t.timestamps
    end
  end
end
