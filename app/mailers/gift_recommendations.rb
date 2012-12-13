require File.expand_path("../../../lib/gateway.rb", __FILE__)

class GiftRecommendations < ActionMailer::Base
  include EventsHelper
  helper :events

  default from: "noreply@giftola.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.gift_recommendations.recommendation.subject
  #
  def recommendation(user, recipient, event)
    @recipient = recipient
    @event = event
    @user = user
    @greeting = "Hi, #{@user.name.split(" ").first}."

    days_until_event = num_days_until(event)
    @event_warning = "#{event.title} will be here in #{days_until_event} days..."
    @upcoming_events = Event.priority(2, @user.id).delete_if { |item| item.title == @event.title }

    recommendation = GiftRecommendation::Gateway.new(recipient, event).recommend
    @top_recommended = recommendation.top_recommended

    mail to: recipient.user.email, subject: "A gift recommendation for #{recipient.name}"
  end
end
