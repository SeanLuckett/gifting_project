require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Landing page" do

    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        :provider => 'facebook',
        :uid => '123545',
        :info => { :name => "Collin Schaafsma" }
      })
      visit root_path
    end

    it { should have_link("Sign in with Facebook") }

    it "sets a session variable to the OmniAuth auth hash" do
      #TODO rewrite this test and session route
      click_link "Sign in with Facebook"
      page.should have_content("Sup?")
    end

  end
end
