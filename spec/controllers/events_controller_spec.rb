require 'spec_helper'

describe EventsController do
  before :each do
    @current_user = create(:user)
    @current_user.events.create(:title => "bday", :date => Date.new(2012, 6, 16))
    @current_user.events.create(:title => "title", :date => Date.yesterday)
    controller.stub!(:current_user).and_return(@current_user)
    controller.stub!(:require_login).and_return(:true)
  end
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "orders events by date, ascending" do
      @events = @current_user.events.all
      @events.last.should == Event.find_by_title("Christmas")
      @events.first.should == Event.find_by_title("Valentine's Day")
    end
  end

  describe "Updating events dates" do
    context "when an event has passed" do
      let(:event) { @current_user.events.find_by_title("title") }
      before { controller.send(:update_events) }

      it "updates its year" do
        event.reload.date.year.should > Time.now.year
      end
    end
  end

end
