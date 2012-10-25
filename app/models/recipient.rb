# == Schema Information
#
# Table name: recipients
#
#  id             :integer          not null, primary key
#  fb_id          :string(255)
#  name           :string(255)
#  image          :string(255)
#  birthday       :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  spend_at_least :integer
#  spend_at_most  :integer
#

class Recipient < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :personas
  has_and_belongs_to_many :events
  attr_accessible :birthday, :image, :name, :fb_id, :spend_at_least,
                  :spend_at_most, :persona_ids, :event_ids

  validates :name, presence: true

  # Right now, this is all kinds of kittens
  # Change at some point
  before_save do |recipient|
    if recipient.image.blank?
      recipient.image = "http://www.placekitten.com/50/50"
    end
  end
end
