require 'spec_helper'

describe Welcomer do
  describe '#welocme_new_user' do
    let(:user) { mock_model(User, :name => 'Matty McTester',
                                  :email => 'tester@email.com') }
    let(:mail) { Welcomer.welcome_new_user(user) }

    it "renders the subject" do
      mail.subject.should == "Welcome to Giftola"
    end

    it "renders the receiver email" do
      mail.to.should ==[user.email]
    end

    it "renders the sender email" do
      mail.from.should == ['noreply@giftola.com']
    end

    it "assigns @name" do
      mail.body.encoded.should match("Matty")
    end
  end
end