class RecipientsController < ApplicationController
  def import_friends
    @user = current_user
  end

  def create
    user = User.find(params[:user_id])
    rec = user.recipients.new(params.slice(:fb_id, :birthday, :name, :image))
    rec.save! unless Recipient.find_by_fb_id(rec.fb_id)

    respond_to do |format|
      format.json { render :json => user.recipients }
    end

  end

end
