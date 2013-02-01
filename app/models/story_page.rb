class StoryPage < ActiveRecord::Base
  attr_accessible :progress, :num, :user_id, :chapter_break
  belongs_to :user
end
