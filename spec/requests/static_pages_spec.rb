require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "logging in" do
    context "when authenticated user" do
      context "when user has no email imported" do
        before do
          set_omniauth :facebook => { :email => nil }
          visit root_path
        end

        it "routes to /static_pages/email_confirm after authentication" do
          click_link("Sign in with Facebook")
          current_path.should == confirm_email_confirm_address_path
        end
      end

      context "when user has an email imported" do
        before do
          set_omniauth
          visit root_path
        end

        it "goes to import Facebook friends page" do
          click_link("Sign in with Facebook")
          current_path.should == import_friends_path
        end
      end
    end
  end

end
