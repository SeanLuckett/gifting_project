class StaticPagesController < ApplicationController
  skip_before_filter :require_login
  
  def home
  end

  def confirm_email
    @user = current_user
  end

  def send_and_confirm
    user = current_user
    unless user.email_confirmed?
      user.update_attributes(params[:user])
      user.send_confirmation_email
      flash[:success] = "Email address saved. Check your inbox to confirm. You may also keep using Giftola."
    end

    go_to_import_or_dashboard(user)
  end

  def save_and_confirm_email
    current_user = User.find_by_oauth_token(params[:auth_token])
    session[:user_id] = current_user.id

    if params[:confirm_email]
      current_user.email_confirmed = true
      current_user.save!
      flash[:success] = "Email address confirmed."
      go_to_import_or_dashboard(current_user)
    end
  end
end
