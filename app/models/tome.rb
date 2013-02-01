class Tome < ActiveRecord::Base
  attr_accessible :completed, :name, :avatar, :puzzles_attributes, :base_back, :cover_page, :theme, :elements, :sequence, :openable, :chapter, :beginning, :ending
  has_many :puzzles, :dependent => :destroy
  has_many :user_states
  has_attached_file :avatar
  has_attached_file :cover_page
end
