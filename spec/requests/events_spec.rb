require 'spec_helper'

describe "Events" do
  before { sign_in_facebook_user }
  let(:user) { User.first }
  subject { page }

  describe "#index" do
    before do
      visit user_events_path(user)
    end

    # When user is creates, default events are created
    context "when viewing user's default events" do
      it { should have_content "Christmas" }
      it { should have_content "Valentine" }
    end

    context "when clicking delete" do
      it "destroys an event" do
        expect { click_link('X') }.to change(Event, :count).by(-1)
        page.should have_content "You removed"
      end
    end
  end
end