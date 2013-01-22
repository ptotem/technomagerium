class Puzzle < ActiveRecord::Base
  attr_accessible :combo, :name, :theme, :lore, :avatar, :power_reward, :mana_reward, :clue_cost_schema
  has_many :games, :dependent => :destroy
  has_attached_file :avatar

end
