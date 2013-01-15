class Puzzle < ActiveRecord::Base
  attr_accessible :combo, :name, :theme, :writeup, :avatar
  has_many :games, :dependent => :destroy
  has_attached_file :avatar

end
