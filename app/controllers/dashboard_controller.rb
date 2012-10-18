class DashboardController < ApplicationController
  layout "app_with_menu"
  def index
    @user = current_user
  end
end
