class StoryPage < ActiveRecord::Base
  attr_accessible :progress, :num, :user_id, :chapter_break
  belongs_to :user

  after_create :bookmarking

  def bookmarking
    @userstate=UserState.find_by_user_id(user_id).bookmark=num
    @userstate.save

  end

end
