require 'spec_helper'

describe EventsController do
  before :each do
    @current_user = create(:user)
    @current_user.events.create(:title => "bday", :date => Date.new(2012, 6, 16))
    controller.stub!(:current_user).and_return(@current_user)
    controller.stub!(:require_login).and_return(:true)
  end
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "orders events by date, descending" do
      @events = @current_user.events.all
      @events.first.should == Event.find_by_title("Christmas")
      @events.last.should == Event.find_by_title("Valentine's Day")
    end
  end

end
