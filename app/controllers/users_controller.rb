class UsersController < ApplicationController
  layout "app_with_menu"

  def edit
    @user = current_user
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
    save_and_confirm_email(@user) if params[:confirm_email]

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def save_and_confirm_email(user)
    flash[:success] = "Email address confirmed."
    user.update_attributes(:email_confirmed => true)
    go_to_import_or_dashboard(user)
  end

end
