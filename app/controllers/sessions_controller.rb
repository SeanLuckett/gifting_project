class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    user.send_welcome_email
    # if user.recipients.blank?
      redirect_to import_friends_path
    # else
      # redirect_to dashboard_index_path
    # end
  end
end
