require 'spec_helper'

describe DashboardController do

  describe "GET 'index'" do
    before :each do
      @current_user = mock_model(User, :id => 1)
      controller.stub!(:current_user).and_return(@current_user)
    end

    it "returns http success" do
      get 'index'
      response.status.should == 200
    end
  end

end
