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

require 'spec_helper'

describe Recipient do
  pending "add some examples to (or delete) #{__FILE__}"
end