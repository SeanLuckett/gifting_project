class EventsController < ApplicationController
  layout 'app_with_menu'
  respond_to :html
  before_filter :get_user
  before_filter :update_events, :only => [:index]
  
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

  def edit
    @event = @user.events.find_by_id(params[:id])
  end

  def update
    params[:event][:recipient_ids] ||= []
    @event = @user.events.find_by_id(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to( user_events_path(@event.user), notice: "Event #{@event.title} updated.") }
      else
        format.html { render action: 'edit' }
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

  def update_events
    current_user.events.each do |event|
      if event.repeats? && Date.today > event.date
        new_date = event.date.change(:year => Time.now.year + 1)
        event.update_attributes(:date => new_date)
      end
    end
  end
end
