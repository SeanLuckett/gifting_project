class RecipientsController < ApplicationController
  layout 'app_with_menu'

  def import_friends
    @user = current_user
  end

  def index
    @user = current_user
    @recipients = @user.recipients.all
  end

  def create
    user = User.find(params[:user_id])
    rec = user.recipients.new(params.slice(:fb_id, :birthday, :name, :image))
    rec.save! unless Recipient.find_by_fb_id(rec.fb_id)

    respond_to do |format|
      format.json { render :json => user.recipients }
    end
  end

  def destroy
    @recipient = Recipient.find(params[:id])
    flash[:notice] = "You removed #{@recipient.name} from the list."
    @recipient.destroy
    redirect_to user_recipients_path(params[:user_id])
  end

end
