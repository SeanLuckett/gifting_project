require 'spec_helper'

describe RecipientsController do
  before :each do
    @current_user = mock_model(User, :id => 1)
    controller.stub!(:current_user).and_return(@current_user)
    controller.stub!(:require_login).and_return(:true)
  end
  
  describe "GET 'import_friends'" do
    it "returns http success" do
      get 'import_friends'
      response.should be_success
    end
  end

end
