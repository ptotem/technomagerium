class AddManualFreezeToTomes < ActiveRecord::Migration
  def change
    add_column :tomes, :manual_freeze, :boolean, :default=> false
  end
end
