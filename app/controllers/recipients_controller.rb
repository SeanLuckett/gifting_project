class RecipientsController < ApplicationController
  layout 'app_with_menu'
  respond_to :html
  before_filter :get_personas, :only => [:new, :create]

  def import_friends
    @user = current_user
  end

  def index
    @user = current_user
    @recipients = @user.recipients.all
  end

  def new
    @user = current_user
    @personas = Persona.all
    @recipient = @user.recipients.build

    respond_with @recipient
  end

  def create
    @user = User.find(params[:user_id])

    if params[:fb_id].present?
      create_from_facebook(@user)
    else
      @recipient = @user.recipients.new(params[:recipient])

      respond_to do |format|
        if @recipient.save
          format.html { redirect_to user_recipients_path(@user), notice: "Recipient successfully created." }
        else
          format.html { render action: "new"}
        end
      end
      
    end
  end

  def create_from_facebook(user)
    rec = user.recipients.new(params.slice(:fb_id, :birthday, :name, :image))
    rec.save! unless Recipient.find_by_fb_id_and_user_id(rec.fb_id, user.id)

    respond_to do |format| 
      format.json { render :json => user.recipients }
    end
  end

  def destroy
    recipient = Recipient.find(params[:id])
    flash[:notice] = "You removed #{recipient.name} from the list."
    recipient.destroy
  redirect_to user_recipients_path(params[:user_id])
  end

  private
  def get_personas
    @personas = Persona.all
  end

end
