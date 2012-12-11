class GiftRecommendations < ActionMailer::Base
  default from: "noreply@giftola.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.gift_recommendations.recommendation.subject
  #
  def recommendation(recipient, event)
    @greeting = "Hi, #{recipient.user.name}"

    mail to: recipient.user.email, subject: "A gift recommendation for #{recipient.name}"
  end
end
