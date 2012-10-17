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
  describe "sending welcome email" do
    before :each do
      ActionMailer::Base.deliveries.clear
      set_omniauth
      @user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
    end

    # let(:user) { User.from_omniauth(OmniAuth.config.mock_auth[:facebook]) }
    context "when user is new" do
      it "sends a welcome email" do
        ActionMailer::Base.deliveries.last.to.should == [@user.email]
      end
    end
    context "when user is not new" do
      it "won't send a duplicate emal" do
        # user2 is same user, so shouldn't create a new one
        user2 = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
        expect{ User.from_omniauth(OmniAuth.config.mock_auth[:facebook]) }.
          not_to change{ ActionMailer::Base.deliveries.count }.
          by(1)
      end
    end
  end

  describe "saving users" do
    before :each do
      set_omniauth
      @user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
    end
    context "when saving new users" do
      it "saves a new user" do
        User.count.should == 1
      end

    context "when saving an existing user"
      it "doesn't save a duplicate" do
        expect{ User.from_omniauth(OmniAuth.config.mock_auth[:facebook]) }
          .not_to change{ User.count }.by(1)
      end
    end
  end
end
