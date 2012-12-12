require File.expand_path("../../../lib/gateway.rb", __FILE__)

class GiftRecommendations < ActionMailer::Base
  default from: "noreply@giftola.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.gift_recommendations.recommendation.subject
  #
  def recommendation(recipient, event)
    @recipient = recipient
    @user = recipient.user
    @greeting = "Hi, #{@user.name.split(" ").first}."

    days_until_event = event.date.day - Date.today.day
    @event_warning = "#{event.title} will be here in #{days_until_event} days..."

    @recommendation = GiftRecommendation::Gateway.new(recipient, event).recommend

    mail to: recipient.user.email, subject: "A gift recommendation for #{recipient.name}"
  end
end
