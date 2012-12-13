class MailPreview < MailView
  def recommendation
    # "fake" data goes here.
    user = User.last
    recipient = user.recipients.first
    event = recipient.events.first
    GiftRecommendations.recommendation(user, recipient, event)
  end
end
