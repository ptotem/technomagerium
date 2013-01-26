class Tome < ActiveRecord::Base
  attr_accessible :completed, :name, :avatar, :puzzles_attributes, :base_back, :cover_page, :theme, :elements
  has_many :puzzles, :dependent => :destroy
  has_attached_file :avatar
  has_attached_file :cover_page
end
