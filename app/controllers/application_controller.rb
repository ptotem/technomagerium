class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_locale
  before_filter :parse_facebook_cookies

  def parse_facebook_cookies
    @facebook_cookies ||= Koala::Facebook::OAuth.new("135450493285811", "2896033cae2b1ce1d396ac41c7ef8fe2").get_user_info_from_cookie(cookies)

    # If you've setup a configuration file as shown above then you can just do
    # @facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
  end


  def set_locale
    if is_a?(RailsAdmin::ApplicationController) or !user_signed_in?
      I18n.locale = :en
    end
  end

end
