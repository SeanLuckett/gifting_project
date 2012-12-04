# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  date       :date             not null
#  user_id    :integer
#  repeats    :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :recipients
  
  attr_accessible :date, :repeats, :title, :recipient_ids

  validates :title, :date, presence: true

  def self.priority(num_weeks, user_id)
    self.where("user_id = ? AND date <= ?", user_id, num_weeks.weeks.since.to_date).order("date ASC")
  end
end
