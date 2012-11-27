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
#  age            :string(255)
#  address1       :string(255)
#  address2       :string(255)
#  state          :string(2)
#  city           :string(255)
#  zip_code       :string(255)
#

class Recipient < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :personas
  has_and_belongs_to_many :events
  attr_accessible :birthday, :image, :name, :fb_id, :spend_at_least,
                  :spend_at_most, :persona_ids, :event_ids, :age, :address1,
                  :address2, :city, :state, :zip_code

  validates :name, presence: true
  validates :spend_at_least, :spend_at_most,
              :numericality => { :only_integer => true }, :unless => "spend_at_least.blank?" 
  validates :age, :numericality => { :only_integer => true }, :unless => "age.blank?"
  validate :spend_at_least_is_less_than_spend_at_most

  def first_name
    self.name.split(" ").first
  end

  # Right now, this is all kinds of kittens
  # Change at some point
  before_save do |recipient|
    if recipient.image.blank?
      recipient.image = "http://www.placekitten.com/50/50"
    end
  end

  def warnings
    warnings = []
    warnings << "Age is blank." if self.age.blank?
    warnings << "Address is incomplete." if self.address_valid?

    warnings
  end

  def spend_at_least_is_less_than_spend_at_most
    unless spend_at_least.blank? || spend_at_most.blank?
      if spend_at_least >= spend_at_most
        errors.add(:spend_at_least, "can't be greater than, or the same as, spend at most.")
      end
    end
  end

  def address_valid?
    state.blank? || address1.blank? || zip_code.blank? || city.blank?
  end
end
