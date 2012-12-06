class User < ActiveRecord::Base
  has_many :recipients, :dependent => :destroy
  has_many :events, :order => 'date ASC'
  attr_accessible :email

  def self.from_omniauth(auth)
    user_exists = self.find_by_uid(auth[:uid])
    return user_exists if user_exists

    where(auth.slice(:uid)).new.tap do |user|
      user.name = auth.info.name
      user.provider = auth.provider
      user.image = auth.info.image
      user.email = auth.info.email
      user.email_confirmed = true unless user.email.blank?
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
      
      user.create_standard_events if user.save
    end
  end

  def send_confirmation_email
    Confirmer.confirm_user_email(self).deliver
  end

  def create_standard_events
    self.events.create(
      title: "Christmas",
      date:  Date.new(2012, 12, 25),
      repeats: true
      )

    self.events.create(
      title: "Valentine's Day",
      date:  Date.new(2012, 2, 14),
      repeats: true
      )
  end
end
