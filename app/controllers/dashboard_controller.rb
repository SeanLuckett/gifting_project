class DashboardController < ApplicationController
  layout "app_with_menu"
  before_filter :build_information_feed

  def index
    @user = current_user
    # is this a new user who's just imported FB friends?
    if params[:import]
      flash[:notice] = "Imported #{params[:numFriends]} Facebook friends."
    end

    if session[:return_to]
      referrer = session[:return_to]
      session.delete(:return_to)

      redirect_to referrer
    end

    @todo_items = build_information_feed
  end

  private
  def build_information_feed
    results = Recipient.with_missing_data
    results
  end

end
