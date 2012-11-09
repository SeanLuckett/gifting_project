require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "logging in" do
    context "when authenticated user" do
      before do
        set_omniauth
        visit root_path
      end

      it "routes to /static_pages/email_confirm after authentication" do
        click_link("Sign in with Facebook")
        current_path.should == static_pages_confirm_email_path
      end
    end
  end

  describe "#email_confirm" do
    before { sign_in_facebook_user }
    let(:user) { User.find_by_name("User Mcfoo") }

    context "when user has a stored email address" do
      let(:field_value) { find_field('user[email]').value }
      it { field_value.should == user.email }
    end

    context "when user has no stored email address" do
      # sets email to "" and reloads page
      before { user.update_attributes(:email => ""); visit current_path}
      let(:field_value) { find_field('user[email]').value }

      it { field_value.should be_empty }
    end

    context "when routing to next step" do
      context "when user hasn't imported facebook friends" do
        it "routes to /recipients/import_friends" do
          click_button 'Confirm'
          current_path.should == import_friends_path
          page.should have_content "Email address saved."
        end
      end

      context "when user has imported facebook friends" do
        before { user.recipients.create(:name => "Harry") }

        it "routes to users dashboard" do
          click_button 'Confirm'
          current_path.should == user_events_path(user)
        end
      end
    end
  end
end
