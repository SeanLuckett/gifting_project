class MailPreview < MailView
  def recommendation
    # "fake" data goes here.
    recipient = User.last.recipients.first
    event = recipient.events.first
    GiftRecommendations.recommendation(recipient, event)
  end
end
