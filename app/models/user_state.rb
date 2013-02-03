class UserState < ActiveRecord::Base
  attr_accessible :tome_id, :user_id, :bookmark
  belongs_to :user
  belongs_to :tome
end
