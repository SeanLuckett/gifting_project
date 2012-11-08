class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
 
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_login
    unless current_user
      redirect_to root_path
    end
  end

  def go_to_import_or_dashboard(user)
    if user.recipients.blank?
      redirect_to import_friends_path
    else
      redirect_to dashboard_index_path
    end
  end
  helper_method :go_to_import_or_dashboard
end
