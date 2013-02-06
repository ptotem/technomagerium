class EncyclopediaEntry < ActiveRecord::Base
  attr_accessible :attack, :defense, :description, :magic, :puzzle_id, :speed
  belongs_to :puzzle
end
