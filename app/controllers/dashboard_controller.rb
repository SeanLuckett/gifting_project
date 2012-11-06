class DashboardController < ApplicationController
  layout "app_with_menu"
  
  def index
    if params[:import]
      redirect_to user_events_path(current_user), notice: "Imported #{current_user.recipients.count} Facebook friends."
    else
      redirect_to user_events_path(current_user)
    end
  end
end
