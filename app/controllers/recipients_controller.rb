class RecipientsController < ApplicationController
  def import_friends
    @user = current_user
  end

  def create
    user = User.find(params[:user_id])
    user.recipients.build(pick(params, :fb_id, :birthday, :name, :image))
    # recipient = user.recipients.find_or_initialize_by_fb_id(params[:recipient][:fb_id])
    # recipient.attributes = {
    #   :fb_id => params[:recipient][:fb_id],
    #   :name => params[:recipient][:name],
    #   :birthday => params[:recipient][:birthday],
    #   # :user_id => params[:recipient][:user_id],
    #   :image => params[:recipient][:image]
    # }
    # recipient.save
    
    end

private

  # To avoid mass assignment errors with backbone.js data, this cleans
  # params and returns only those attributes specified with *keys
  # example:  pick(params, :fb_id, :name)
  def pick(hash, *keys)
    filtered = {}
    hash.each do |key, value| 
      filtered[key.to_sym] = value if keys.include?(key.to_sym) 
    end
    filtered
  end

end
