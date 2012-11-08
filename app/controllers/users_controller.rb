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

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
end
