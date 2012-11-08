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
end
