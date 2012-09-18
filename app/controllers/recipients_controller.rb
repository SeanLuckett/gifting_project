class RecipientsController < ApplicationController
  def import_friends
    @user = current_user
  end
end
