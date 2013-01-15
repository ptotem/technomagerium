class Game < ActiveRecord::Base
  attr_accessible :puzzle_id, :solved, :user_id
  belongs_to :user
  belongs_to :puzzle

  delegate :background, :to=> :puzzle
  delegate :selector, :to=> :puzzle
  delegate :writeup, :to=> :puzzle
  delegate :combo, :to=> :puzzle

end
