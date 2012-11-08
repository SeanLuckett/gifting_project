class UsersController < ApplicationController
  layout "app_with_menu"
  skip_before_filter :require_login, :only => [:save_and_confirm_email]

  def edit
    @user = current_user
  end

  def show
    @user = current_user
  end

  def update
    save_and_confirm_email if params[:confirm_email]
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def save_and_confirm_email
    current_user = User.find_by_oauth_token(params[:auth_token])

    if current_user
      flash[:success] = "Email address confirmed."
      current_user.update_attributes(:email_confirmed => true)
      go_to_import_or_dashboard(user)
    end
  end

end
