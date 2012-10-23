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

require 'spec_helper'

describe Recipient do
  subject { FactoryGirl.create(:recipient)}

  it { should respond_to(:birthday) }
  it { should respond_to(:image) }
  it { should respond_to(:name) }
  it { should respond_to(:fb_id) }
  it { should respond_to(:user_id) }

  it { should be_valid }
end
