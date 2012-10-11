# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  provider         :string(255)
#  uid              :string(255)
#  name             :string(255)
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  email            :string(255)
#  image            :string(255)
#

require 'spec_helper'

describe User do
  subject { FactoryGirl.create(:user)}

  it "sends a welcome email" do
    subject.send_welcome_email
    ActionMailer::Base.deliveries.last.to.should == [subject.email]
  end
end
