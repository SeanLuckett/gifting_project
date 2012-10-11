class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    user.send_welcome_email
    redirect_to import_friends_path
  end
end
