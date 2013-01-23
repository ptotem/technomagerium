class Puzzle < ActiveRecord::Base
  attr_accessible :combo, :name, :theme, :lore, :avatar, :power_reward, :mana_reward, :clue_cost_schema, :tome_id
  has_many :games, :dependent => :destroy
  has_attached_file :avatar
  belongs_to :tome

end
