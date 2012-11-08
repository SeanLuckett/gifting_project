class Confirmer < ActionMailer::Base
  default from: "noreply@giftola.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcomer.welcome_new_user.subject
  #
  def confirm_user_email(user)
    @user = user

    mail to: user.email, subject: "Giftola: confirm your email address"
  end
end
