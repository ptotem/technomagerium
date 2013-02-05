class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin, :power, :mana, :score

  has_many :games, :dependent => :destroy
  has_many :story_pages, :dependent => :destroy
  has_one :user_state

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password.
      User.create!(:email => data.email, :password => Devise.friendly_token[0, 20])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  after_create :create_story_pages
  after_save :admin_privileges

  def create_story_pages
    unless Tome.first.nil?
      @tome=Tome.first
      UserState.create!(user_id: id, tome_id: @tome.id, bookmark: 0)
      StoryPage.create!(user_id: id, num: 1, progress: @tome.id, chapter_break: true)
      @last_page=self.story_pages.last.num
      @tome.ending.split("||").each_with_index do |e, index|
        StoryPage.create!(user_id: id, num: (@last_page+index+1), progress: e)
      end
      @next_tome=Tome.find_by_sequence(2)
      StoryPage.create!(user_id: id, num: 1, progress: @next_tome.id, chapter_break: true)
      @last_page=self.story_pages.last.num
      @next_tome.beginning.split("||").each_with_index do |e, index|
        StoryPage.create!(user_id: id, num: (@last_page+index+1), progress: e)
      end
    end
  end

  def admin_privileges
    unless Tome.first.nil?

      if self.admin
        StoryPage.all.each do |p|
          p.destroy
        end
        UserState.create!(user_id: id, tome_id: Tome.all.last.id, bookmark: 0)
        @tome=Tome.first
        StoryPage.create!(user_id: id, num: 1, progress: @tome.id, chapter_break: true)
        @last_page=self.story_pages.last.num
        @tome.ending.split("||").each_with_index do |e, index|
          StoryPage.create!(user_id: id, num: (@last_page+index+1), progress: e)
        end
        Tome.all[1..-1].each_with_index do |tome, index|
          @last_page=self.story_pages.last.num
          StoryPage.create!(user_id: id, num: @last_page+1, progress: tome.id, chapter_break: true)
          @last_page=self.story_pages.last.num
          tome.beginning.split("||").each_with_index do |e, index|
            StoryPage.create!(user_id: id, num: (@last_page+index+1), progress: e)
          end
          @last_page=self.story_pages.last.num
          tome.ending.split("||").each_with_index do |e, index|
            StoryPage.create!(user_id: id, num: (@last_page+index+1), progress: e)
          end
        end
      end
    end
  end

end
