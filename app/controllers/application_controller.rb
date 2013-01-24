class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter do
    authenticate_user! rescue redirect_to 'auth/facebook'
  end
  before_filter :set_locale

  def set_locale
    if is_a?(RailsAdmin::ApplicationController) or !user_signed_in?
      I18n.locale = :en
    end
  end

end
