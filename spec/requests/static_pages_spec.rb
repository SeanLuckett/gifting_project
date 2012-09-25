require 'spec_helper'

describe "StaticPages" do
  subject { page }

  define "authenticated user" do
    describe "Landing page" do
      before do
        set_omniauth
        visit root_path
      end

      it "routes to recipients#import_friends after authentication" do
        click_link("Sign in with Facebook")
        page.should have_content("Import your Facebook friends")
      end
    end
  end
  define "unauthenticated user" do
    pending
  end
end
