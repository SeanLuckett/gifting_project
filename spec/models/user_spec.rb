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
    expect{ subject.send_welcome_email }.to change{ ActionMailer::Base.deliveries.count }.by(1)
  end

  context "when saving new users" do
    it "saves a new user" do
      pending
      set_omniauth
      user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
    end

  context "when saving an existing user"
    it "finds a user already in db" do
      pending
      set_omniauth
      user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
      expect{ click_link("Sign in with Facebook") }.not_to change{ User.count }.by(1)
    end
  end
end
