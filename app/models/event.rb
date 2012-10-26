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
  
  attr_accessible :date, :repeats, :title

  validates :title, :date, presence: true
end
