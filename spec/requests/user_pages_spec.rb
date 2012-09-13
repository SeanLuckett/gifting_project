require 'spec_helper'

describe "User pages" do

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
      it { should have_selector(:xpath, "//img[@src='#{user.image}']") }
      it { should have_link('change',    href: "/users/#{user.id}/edit") }

    end

    context "when editing" do
      before { click_link "change" }

      it { should have_selector("input", value: user.email) }

      context "when changing email" do
        before do
          fill_in("user_email", with: "test@example.net")
          click_button("Done")
        end

        specify { user.reload.email.should eq("test@example.net") }

      end
    end
  end
end
