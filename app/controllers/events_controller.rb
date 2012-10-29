class EventsController < ApplicationController
  layout 'app_with_menu'
  respond_to :html
  
  def index
    @user = User.find_by_id(params[:user_id])
    @events = @user.events.all
  end

  def destroy
    event = Event.find_by_id(params[:id])
    flash[:notice] = "You removed #{event.title} from the list."
    event.destroy
    redirect_to user_events_path(params[:user_id])
  end
end
