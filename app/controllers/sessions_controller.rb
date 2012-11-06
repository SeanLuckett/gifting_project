class SessionsController < ApplicationController
  skip_before_filter :require_login
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if user.recipients.blank?
      redirect_to import_friends_path
    else
      redirect_to dashboard_index_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
