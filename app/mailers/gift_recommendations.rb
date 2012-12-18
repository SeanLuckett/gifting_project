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

    # save the top_recommended for gift purchaser. User could change it at some point
    gift_to_buy = RecommendedGifts.new(
      :recipient_id   => @recipient.id,
      :event_id       => @event.id,
      :gift_name      => @top_recommended[:title],
      :gift_url       => @top_recommended[:url],
    )
    gift_to_buy.save
    mail to: recipient.user.email, subject: "A gift recommendation for #{recipient.name}"
  end
end
