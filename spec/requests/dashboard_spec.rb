require 'spec_helper'

describe "Dashboard" do
  before :each do
    sign_in_facebook_user
    @user = User.first
  end

  subject { page }

  describe "index page" do
    it "has link: 'Profile'" do
      visit "/dashboard/index"
      page.should have_link("Profile")
    end

    describe "missing data and upcoming events feed" do
      context "when recient has missing data" do
        it "shows on the list" do
          create(:recipient, :name => "Harry", :user_id => @user.id)
          visit "/dashboard/index"

          page.should have_content "Harry"
        end
      end

      context "when recipient has NO missing data" do
        it "doesn't show on list" do
          create(:recipient, :name => "Sally", :user_id => @user.id,
                 :address1 => "123 main", :city => "Springfield",
                 :state => "MO", :zip_code => "80002")
          visit "/dashboard/index"

          page.should_not have_content "Sally"
        end
      end

      context "when events are happening soon" do
        it "shows on list" do
          create(:event, :title => "Awesome Sauce", :date => 1.week.since.to_date,
                 :user_id => @user.id)
          visit "/dashboard/index"

          page.should have_content "Awesome Sauce"
        end
      end
    end
  end
end
