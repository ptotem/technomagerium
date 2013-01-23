class Tome < ActiveRecord::Base
  attr_accessible :completed, :name, :avatar, :puzzles_attributes
  has_many :puzzles, :dependent => :destroy
  has_attached_file :avatar
  accepts_nested_attributes_for :puzzles
end
