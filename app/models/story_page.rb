class StoryPage < ActiveRecord::Base
  attr_accessible :progress, :num, :user_id
  belongs_to :user
end
