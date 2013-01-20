class Game < ActiveRecord::Base
  attr_accessible :puzzle_id, :solved, :user_id, :lore, :counter, :revelation
  belongs_to :user
  belongs_to :puzzle

end
