load Rails.root + "lib/gateway.rb"

class Api::RecommendationsController < ApplicationController
  respond_to :json
  include GiftRecommendation
  before_filter :set_default_response_format

  skip_before_filter :require_login

  def generate
    recipient = current_user.recipients.first #hard coded for now
    event = current_user.events.first #also hard coded for now
    gateway = Gateway.new(recipient, event)

    @recommendation = gateway.recommend
    respond_with @recommendation
  end

  private
  def set_default_response_format
    request.format = :json unless params[:format]
  end
end