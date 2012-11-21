class RecommendationsController < ApplicationController
  respond_to :json

  skip_before_filter :require_login

  def generate
    recipient = current_user.recipients.first #hard coded for now
    gateway = GiftRecommendation::Gateway.new(recipient)

    @recommendation = gateway.recommend
  end
end