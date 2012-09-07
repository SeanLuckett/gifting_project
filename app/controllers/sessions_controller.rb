class SessionsController < ApplicationController
  def test_page
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to import_friends_path
  end
end
