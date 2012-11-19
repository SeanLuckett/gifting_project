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
#  email_confirmed  :boolean          default(FALSE)
#

require 'spec_helper'

describe User do
  describe "sending welcome email" do
    before :each do
      ActionMailer::Base.deliveries.clear
      set_omniauth
      @user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
    end

    context "when user is not new" do
      it "won't send a duplicate email" do
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

      it "gives user some standard events to work with" do
        @user.events.count.should > 0
      end
    end

    context "when saving an existing user" do
      it "doesn't save a duplicate" do
        expect{ User.from_omniauth(OmniAuth.config.mock_auth[:facebook]) }
          .not_to change{ User.count }.by(1)
      end
    end

    context "when deleting a user" do
      before do
        create(:recipient, :user_id => @user.id)
        create(:recipient, :id => 20, :user_id => @user.id)
      end

      it "destroys all, associated recpients" do
        expect{ @user.destroy }.to change{ @user.recipients.count }.to(0)
      end
    end
  end
end
