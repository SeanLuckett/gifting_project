class DashboardController < ApplicationController
  layout "app_with_menu"

  def index
    # is this a new user who's just imported FB friends?
    if params[:import]
      flash[:notice] = "Imported #{params[:numFriends]} Facebook friends."
    end

    # so long as this redirects somewhere else, flash messages can get lost
    # remove this once index/dashboard is the dashboard path
    if flash[:success]
      flash[:success] = flash[:success]
    end

    if session[:return_to]
      redirect_to session[:return_to] 
    else
      redirect_to user_events_path(current_user)
    end
  end
end
