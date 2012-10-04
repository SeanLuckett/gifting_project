class RecipientsController < ApplicationController
  def import_friends
    @user = current_user
  end

  def create
    recipient = Recipient.find_or_initialize_by_fb_id(params[:recipient][:fb_id])
    recipient.attributes = {
      :fb_id => params[:recipient][:fb_id],
      :name => params[:recipient][:name],
      :birthday => params[:recipient][:birthday],
      :user_id => params[:recipient][:user_id],
      :image => params[:recipient][:image]
    }
    recipient.save
    
    render :json => recipient
  end
end
