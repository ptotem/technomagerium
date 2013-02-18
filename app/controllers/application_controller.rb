class ApplicationController < ActionController::Base
  #protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_locale

  def set_locale
    if is_a?(RailsAdmin::ApplicationController) or !user_signed_in?
      I18n.locale = :en
    end
  end

  def after_sign_in_path_for(resource)
    if current_user.user_state.blank?
      "/library/1"
    else
      library_path(current_user.user_state.tome.chapter)
    end
  end

end
