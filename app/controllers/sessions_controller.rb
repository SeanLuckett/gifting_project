class SessionsController < ApplicationController
  skip_before_filter :require_login

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    unless user.email_confirmed?
      redirect_to confirm_email_confirm_address_path
    else
      go_to_import_or_dashboard(user)
    end
  end


  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
