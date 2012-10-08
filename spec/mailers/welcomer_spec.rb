require 'spec_helper'

describe Welcomer do
  describe '#welcome_new_user' do
    let(:user) { mock_model(User, :name => 'Matty McTester',
                                  :email => 'tester@email.com') }
    let(:mail) { Welcomer.welcome_new_user(user) }

    it "renders the subject" do
      mail.subject.should == "Welcome to Giftola"
    end

    it "renders the receiver email" do
      mail.to.should ==[user.email]
    end
  end
end