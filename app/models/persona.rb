class Persona < ActiveRecord::Base
  has_and_belongs_to_many :recipients
  attr_accessible :description, :title

  validates :title, presence: true
end
