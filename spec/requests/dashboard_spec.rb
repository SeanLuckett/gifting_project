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

    describe "missing data and upcoming events feed" do
      context "when recient has missing data" do
        before do
          create(:recipient, :name => "Harry", :user_id => @user.id)
          create(:recipient, :name => "Sally",
                 :user_id => @user.id,
                 :address1 => "123 main",
                 :city => "Springfield",
                 :state => "MO",
                 :zip_code => "80002")

          visit "/dashboard/index"
        end

        it "shows on the list" do
          page.should have_content "Harry"
          page.should_not have_content "Sally"
        end
      end
    end
  end
end
