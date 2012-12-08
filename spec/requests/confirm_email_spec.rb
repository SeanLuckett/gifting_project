require 'spec_helper'

describe "ConfirmEmail" do
  subject { page } 

  describe "#confirm_address" do
    before :each do
      set_omniauth :facebook => { :email => nil, :name => "User McFoo" }
      visit root_path
      click_link("Sign in with Facebook")
    end

    context "when user has no stored email address" do

      let(:field_value) { find_field('user[email]').value }

      it { field_value.should be_nil }
    end

    context "when user hasn't imported facebook friends" do
      it "routes to /recipients/import_friends" do
        click_button 'Confirm'
        current_path.should == import_friends_path
        page.should have_content "Email address saved."
      end
    end

    context "when user has imported facebook friends" do
      before do
        user = User.find_by_name("User McFoo")
        user.update_attributes(:email => "user@example.com")
        user.recipients.create(:name => "Harry")
        visit current_path
      end

      it "routes to users dashboard" do
        click_button 'Confirm'
        current_path.should == dashboard_index_path
      end
    end
  end
end
