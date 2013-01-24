class ApplicationController < ActionController::Base
  #protect_from_forgery
  before_filter :set_locale
  before_filter :parse_facebook_cookies
  before_filter :authenticate_user!

  def parse_facebook_cookies
   @facebook_cookies = Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
   #@graph = Koala::Facebook::GraphAPI.new(@facebook_cookies["access_token"])
  end

  def set_locale
    if is_a?(RailsAdmin::ApplicationController) or !user_signed_in?
      I18n.locale = :en
    end
  end

end
