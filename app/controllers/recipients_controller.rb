class RecipientsController < ApplicationController
  def import_friends
    @user = current_user
  end

  def create
    user = User.find(params[:user_id])
    rec = user.recipients.new(pick(params, :fb_id, :birthday, :name, :image))
    rec.save!

    respond_to do |format|
      format.json { render :json => user.recipients }
    end

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
