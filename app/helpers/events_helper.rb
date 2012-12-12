module EventsHelper
  def display_recipient(recipient)
    if recipient.warnings.blank?
      link_to image_tag(recipient.image), edit_user_recipient_path(@user, recipient)
    else
      link_to image_tag(recipient.image, :class => "has-warnings"), edit_user_recipient_path(@user, recipient)
    end
  end

  def num_days_until(event)
    event.date.day - Date.today.day
  end
end
