# == Schema Information
#
# Table name: recipients
#
#  id         :integer          not null, primary key
#  fb_id      :string(255)
#  name       :string(255)
#  image      :string(255)
#  birthday   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Recipient < ActiveRecord::Base
  belongs_to :user
  attr_accessible :birthday, :image, :name, :fb_id
end
