class Puzzle < ActiveRecord::Base
  attr_accessible :combo, :name, :lore, :avatar, :power_reward, :mana_reward, :clue_cost_schema, :tome_id, :manacost, :explanation,:sequence
  has_many :games, :dependent => :destroy
  has_one :encyclopedia_entry, :dependent => :destroy
  has_attached_file :avatar
  belongs_to :tome

  def clue_cost_schema_enum
    ['none', 'steep', 'cheap', 'flat','count','lore' ]
  end

end
