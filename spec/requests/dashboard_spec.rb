require 'spec_helper'

describe "Dashboard" do
  subject { page }

  describe "index page" do
    before do
      sign_in_facebook_user
      @user = User.first
      visit "/dashboard/index"
    end

    it "has link: 'Profile'" do
      page.should have_link("Profile")
    end

    describe "'news' feed" do
      context "when recient has missing data" do
        before { create(:recipient, :name => "Harry", :user_id => @user.id) }
        it "shows on the list" do
          pending "come back when to do items are represented and tested"
          page.should have_content "Harry"
        end
      end
    end
  end
end
