#
# Table name: users
#
#  id               :integer          not null, primary key
#  provider         :string(255)
#  uid              :string(255)
#  name             :string(255)
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  email            :string(255)
#  image            :string(255)
#

class User < ActiveRecord::Base
  has_many :recipients
  has_many :events
  attr_accessible :email

  before_save :create_standard_events
  after_save :send_welcome_email

  def self.from_omniauth(auth)
    user = self.find_by_uid(auth[:uid])
    return user if user

    where(auth.slice(:uid)).new.tap do |user|
      user.name = auth.info.name
      user.image = auth.info.image
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def send_welcome_email
    Welcomer.welcome_new_user(self).deliver
  end

  def create_standard_events
    self.events.build(
      title: "Christmas",
      date:  Date.new(2012, 12, 25),
      repeats: true
      )

    self.events.build(
      title: "Valentine's Day",
      date:  Date.new(2012, 2, 14),
      repeats: true
      )
  end
end
