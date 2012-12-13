require 'spec_helper'

describe ConfirmEmailController do
  before :each do
    @current_user = create(:user)
    controller.stub!(:current_user).and_return(@current_user)
  end

  describe "#send_email_to_address" do
    context "when email not confirmed" do
      it "sends email" do
        post :send_email_to_address
        ActionMailer::Base.deliveries.last.to.should == [@current_user.email]
      end

      context "when user changes email address from one FB supplies" do
        it "saves new address" do
          old_email = @current_user.email
          @current_user.email = "changed@example.com"
          post :send_email_to_address
          new_email = User.find_by_id(@current_user.id).email

          new_email.should_not == old_email
        end
      end
    end
    describe "redirecting after" do
      context "when user hasn't imported friends" do
        it "redirects to import friends path" do
          post :send_email_to_address
          response.should redirect_to import_friends_path
        end
      end

      context "when user has already imported friends" do
        it "redirects to user dash board" do
          create(:recipient, :user_id => @current_user.id)
          post :send_email_to_address
          response.should redirect_to dashboard_index_path
        end
      end
    end
  end

  describe "#save_address_record_confirmed" do
    before :each do
      get :save_address_record_confirmed, { :auth_token => @current_user.oauth_token,
                                   :confirm_email => true }
    end

    it "changes email_confirmed to true" do
      User.find_by_id(@current_user.id).email_confirmed.should == true
      response.should redirect_to import_friends_path
    end

    context "when user hasn't imported friends" do
      it { should redirect_to import_friends_path }
    end

    context "when user has imported friend" do
      it "redirects to dashboard" do
        create(:recipient, :user_id => @current_user.id)
        get :save_address_record_confirmed, :auth_token => @current_user.oauth_token,
                                   :confirm_email => true
        response.should redirect_to dashboard_index_path
      end
    end
  end

end
