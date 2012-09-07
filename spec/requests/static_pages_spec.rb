require 'spec_helper'
require 'debugger'

describe "StaticPages" do
  subject { page }

  describe "Landing page" do

    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        :provider => 'facebook',
        :uid => '123545',
        :info => { :name => "Collin Schaafsma" },
        :credentials => {
          :token => "ABCDEF...",
          :expires_at => Time.now
        }
      })
      visit root_path
    end

    it "routes to recipients#import_friends after authentication" do
      click_link("Sign in with Facebook")
      page.should have_content("Import your friends from Facebook")
    end

    context "Saving new, and recognizing old, users" do
      it "saves a new user" do
        expect{ click_link("Sign in with Facebook") }.to change{ User.count }.by(1)
      end

      it "finds a user already in db" do
        user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
        expect{ click_link("Sign in with Facebook") }.not_to change{ User.count }.by(1)
      end
    end
  end
end
