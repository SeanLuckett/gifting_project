require 'spec_helper'

describe "User" do

  subject { page }

  describe "profile page" do
    let(:user) { User.first }
    before do
      sign_in_user
      visit user_path(user)
    end

    context "when viewing" do

      it { should have_selector('title', text: user.name) }
      it { should have_selector('h1',    text: user.name) }
      it { should have_selector('h3',    text: user.email) }
      # investigate !xpath
      it { should have_selector(:xpath, "//img[@src='#{user.image}']") }
      it { should have_link('change',    href: "/users/#{user.id}/edit") }

    end

    context "when editing" do
      before { click_link "change" }

      context "when changing email" do
        before do
          fill_in("user_email", with: "test@example.net")
          click_button("Done")
        end

        specify { user.reload.email.should eq("test@example.net") }

      end
    end

    # this context is better for User spec
    pending "Two tests to integrate"
    # context "Saving new, and recognizing old, users" do
    #   it "saves a new user" do
    #     expect{ click_link("Sign in with Facebook") }.to change{ User.count }.by(1)
    #   end

    #   it "finds a user already in db" do
    #     user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
    #     expect{ click_link("Sign in with Facebook") }.not_to change{ User.count }.by(1)
    #   end
    # end
  end
end
