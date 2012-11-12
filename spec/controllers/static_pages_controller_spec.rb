require 'spec_helper'

describe StaticPagesController do
  before :each do
    @current_user = create(:user)
    controller.stub!(:current_user).and_return(@current_user)
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end


end
