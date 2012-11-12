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
        current_path.should == confirm_email_confirm_address_path
      end
    end
  end

end
