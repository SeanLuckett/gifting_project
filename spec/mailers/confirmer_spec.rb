require 'spec_helper'

describe Confirmer do
  describe '#confirm_user_email' do
    let(:user) { mock_model(User, :name => 'Matty McTester',
                                  :email => 'tester@email.com') }
    let(:mail) { Confirmer.confirm_user_email(user) }

    it "renders the subject" do
      mail.subject.should == "Giftola: confirm your email address"
    end

    it "renders the receiver email" do
      mail.to.should ==[user.email]
    end

    it "renders the sender email" do
      mail.from.should == ['noreply@giftola.com']
    end

    it "assigns @name" do
      mail.body.encoded.should match("email address")
    end
  end
end