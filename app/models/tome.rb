class Tome < ActiveRecord::Base
  attr_accessible :completed, :name, :avatar, :puzzles_attributes, :base_back, :cover_page, :theme, :elements, :sequence, :openable, :chapter, :beginning, :ending, :manual_freeze
  has_many :puzzles, :dependent => :destroy
  has_many :user_states
  has_attached_file :avatar
  has_attached_file :cover_page

  before_save :markup_beginning
  before_save :markup_ending

  def markup_beginning
    unless manual_freeze
      n=110
      self.beginning=self.beginning.gsub("||", " ")
      self.beginning=self.beginning.gsub("|p|", " ")
      word_count=self.beginning.split.size
      pages=(word_count/n).ceil+1
      pieces=[]
      pages.times do |s|
        pieces<<self.beginning.gsub(/\r?\n/, "<br/>").split(/\s+/, n*(s+1)+1)[n*s...n*(s+1)].join(' ')
      end
      result=""
      pieces.each_with_index do |piece, index|
        result=result+piece+(index%2==0 ? "|p|" : "||")
      end
      self.beginning=result
    end
  end

  def markup_ending
    unless manual_freeze
      n=110
      self.ending=self.ending.gsub("||", " ")
      self.ending=self.ending.gsub("|p|", " ")
      word_count=self.ending.split.size
      pages=(word_count/n).ceil+1
      pieces=[]
      pages.times do |s|
        pieces<<self.ending.gsub(/\r?\n/, "<br/>").split(/\s+/, n*(s+1)+1)[n*s...n*(s+1)].join(' ')
      end
      result=""
      pieces.each_with_index do |piece, index|
        result=result+piece+(index%2==0 ? "|p|" : "||")
      end
      self.ending=result
    end
  end

end
