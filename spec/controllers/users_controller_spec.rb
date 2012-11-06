require 'spec_helper'

describe UsersController do
  before :each do
    @current_user = mock_model(User, :id => 1)
    controller.stub!(:current_user).and_return(@current_user)
    controller.stub!(:require_login).and_return(:true)
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
