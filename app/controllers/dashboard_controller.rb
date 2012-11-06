class DashboardController < ApplicationController
  layout "app_with_menu"

  def index
    # is this a new user who's just imported FB friends?
    if params[:import]
      flash[:notice] = "Imported #{current_user.recipients.count} Facebook friends."
    end
    redirect_to user_events_path(current_user)
  end
end
