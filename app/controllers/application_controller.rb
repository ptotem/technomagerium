class ApplicationController < ActionController::Base
  protect_from_forgery
  #TODO: before_filter :authenticate_user!
  before_filter :set_locale

  def set_locale
    if is_a?(RailsAdmin::ApplicationController) or !user_signed_in?
      I18n.locale = :en
    end
  end



end
