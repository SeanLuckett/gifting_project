class RecipientsController < ApplicationController
  layout 'app_with_menu'
  respond_to :html
  skip_before_filter :require_login, :only => [:create, :create_from_facebook]
  before_filter :get_personas, :except => [:create_from_facebook, :import_friends]
  before_filter :get_user

  def import_friends
  end

  def index
    @recipients = @user.recipients.all
  end

  def new
    @recipient = @user.recipients.build

    respond_with @recipient
  end

  def show
    @recipient = @user.recipients.find_by_id(params[:id])
  end

  def create
    if params[:fb_id].present?
      # before filter for getting user doesn't work with fb content 
      # as implemented with Backbone.js
      @user = User.find_by_id(params[:user_id])
      create_from_facebook(@user)
    else
      @recipient = @user.recipients.new(params[:recipient])

      respond_to do |format|
        if @recipient.save
          format.html { redirect_to user_recipients_path(@user), notice: "Recipient created." }
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

  def edit
    @recipient = @user.recipients.find_by_id(params[:id])
  end

  def update
    @recipient = @user.recipients.find_by_id(params[:id])

    respond_to do |format|
      if @recipient.update_attributes(params[:recipient])
        format.html { redirect_to( user_recipients_path(@recipient.user), notice: "Recipient #{@recipient.name} updated.") }
      else
        format.html { render action: 'edit'}
      end
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

  def get_user
    @user = current_user
  end

end
