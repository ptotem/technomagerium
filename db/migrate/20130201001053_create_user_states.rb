class CreateUserStates < ActiveRecord::Migration
  def change
    create_table :user_states do |t|
      t.integer :user_id
      t.integer :tome_id

      t.timestamps
    end
  end
end
