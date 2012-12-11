require "spec_helper"

describe GiftRecommendations do
  describe "recommendation" do
    let(:user) { create(:user, :email => 'tester@email.com') }
    let(:event) { create(:event, :title => "Winter-een-mas", :date => 10.days.since.to_datetime, :user_id => user.id ) }
    let(:recipient) { create(:recipient, :name => "Jerry Hartford", :user_id => user.id, :events => [event]) }
    let(:mail) { GiftRecommendations.recommendation(recipient, event) }

    it "renders the subject" do
      mail.subject.should eq("A gift recommendation for #{recipient.name}")
    end

    it "renders the receiver email" do
      mail.to.should eq(["tester@email.com"])
    end

    it "renders the sender email" do
      mail.from.should eq(["noreply@giftola.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("#{recipient.user.name}")
    end
  end

end
