# == Schema Information
#
# Table name: personas
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Persona < ActiveRecord::Base
  has_and_belongs_to_many :recipients
  attr_accessible :description, :title

  validates :title, presence: true
end
