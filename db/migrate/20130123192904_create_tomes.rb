class CreateTomes < ActiveRecord::Migration
  def change
    create_table :tomes do |t|
      t.string :name
      t.string :theme
      t.string :elements
      t.boolean :completed
      t.has_attached_file :avatar
      t.has_attached_file :cover_page

      t.timestamps
    end
  end
end
