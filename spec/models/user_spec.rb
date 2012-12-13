require 'spec_helper'

describe User do
  describe "sending recommendation email" do
    before do
      @user = User.from_omniauth(set_omniauth)
      ActionMailer::Base.deliveries.clear
    end

    it "sends the email" do
      user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
      event = create(:event)
      persona = create(:persona, :title => "Nerd")
      recipient = create(:recipient, :user_id => user.id, :personas => [persona], :events => [event])

      user.send_recommendation(recipient, event)
      ActionMailer::Base.deliveries.last.to.should == [user.email]
    end
  end

  describe "sending welcome email" do
    before :each do
      ActionMailer::Base.deliveries.clear
    end

    context "when user is not new" do
      it "won't send a duplicate email" do
        user2 = User.from_omniauth(set_omniauth)
        expect{ User.from_omniauth(set_omniauth) }.
          not_to change{ ActionMailer::Base.deliveries.count }.
          by(1)
      end
    end
  end

  describe "email confirmation" do
    context "when user's email imported from Facebook" do
      it "sets #email_confirmed to true" do
        user = User.from_omniauth(set_omniauth)

        user.email_confirmed.should be_true
      end
    end

    context "when user's email not imported from Facebook or just blank" do
      it "leaves #email_confirmed false" do
        #set_omniauth :facebook => { :email => nil }
        user = User.from_omniauth(set_omniauth :facebook => { :email => nil })

        user.email_confirmed.should be_false
      end
    end
  end

  describe "saving users" do
    before :each do
      @user = User.from_omniauth(set_omniauth)
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
