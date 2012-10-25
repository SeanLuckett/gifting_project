# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  date       :date             not null
#  repeats    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ActiveRecord::Base
  attr_accessible :date, :repeats, :title

  validates :title, :date, presence: true
end
