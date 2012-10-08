class Welcomer < ActionMailer::Base
  default from: "noreply@giftola.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcomer.welcome_new_user.subject
  #
  def welcome_new_user(user)
    @name = user.name.split(' ').first

    mail to: user.email, subject: "Welcome to Giftola"
  end
end
