class DashboardController < ApplicationController
  layout "app_with_menu"
  def index
    redirect_to user_events_path(current_user)
  end
end
