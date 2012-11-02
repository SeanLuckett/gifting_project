module RecipientsHelper
  def display_recipient_birthday(recipient)
    if recipient.birthday
      return recipient.birthday.to_s(:long)
    else
      return "Not entered"
    end
  end
end
