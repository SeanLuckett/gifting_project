require 'spec_helper'

describe "Recipients" do
  before { sign_in_facebook_user }
  let(:user) { User.first }
  subject { page }

  describe "#index" do
    before do
      ["Phil", "Janice"].each do |name|
        user.recipients.create(:name => name)
      end

      visit user_recipients_path(user)
    end

    context "when viewing user's recipients" do
      it { should have_content "Phil" }
      it { should have_content "Janice" }
    end

    context "when clicking delete" do
      it "destroys a recipient" do
        expect { click_link('X') }.to change(Recipient, :count).by(-1)
      end
    end
  end
end