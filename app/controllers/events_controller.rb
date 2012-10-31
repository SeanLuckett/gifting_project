class EventsController < ApplicationController
  layout 'app_with_menu'
  respond_to :html
  before_filter :get_user
  
  def index
    @events = @user.events.all
  end

  def new
    @event = @user.events.build

    respond_with @event
  end

  def create
    @event = @user.events.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to user_events_path(@user), notice: "Event created." }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    event = Event.find_by_id(params[:id])
    flash[:notice] = "You removed #{event.title} from the list."
    event.destroy
    redirect_to user_events_path(params[:user_id])
  end

  private
  def get_user
    @user = current_user
  end
end
