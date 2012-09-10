require 'spec_helper'

describe "Dashboard" do
  subject { page }

  describe "index page" do
    before do
      sign_in_user
      visit "/dashboard/index"
    end

    it "has link: 'Profile'" do
      page.should have_link("Profile")
    end
  end
end
