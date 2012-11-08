require 'spec_helper'

describe EventsController do
  before :each do
    @current_user = create(:user)
    @current_user.events.create(:title => "One", :date => Date.new(2012, 12, 25))
    @current_user.events.create(:title => "Two", :date => Date.new(2012, 2, 14))
    controller.stub!(:current_user).and_return(@current_user)
    controller.stub!(:require_login).and_return(:true)
  end
  
  describe "GET 'index'" do
    before do
      @current_user.events.create(:title => "bday", :date => Date.new(2012, 6, 16))
    end

    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "orders events by date, ascending" do
      @events = @current_user.events.all
      @events.first.title.should == "Two"
      @events.last.title.should == "One"
    end
  end

  describe "Updating event dates" do
    context "when event doesn't repeat" do
      before do
        @current_user.events.create(:title => "No repeat", :date => Date.yesterday, :repeats => false)
      end
      let(:event) { @current_user.events.find_by_title("No repeat") }

      it "doesn't get updated with new year" do
        expect{ controller.send(:update_events) }.to_not change{ event.date.year }.by(1)
      end
    end

    context "when a repeating event has passed" do
      before do
        @current_user.events.create(:title => "title", :date => Date.yesterday)
      end
      let(:event) { @current_user.events.find_by_title("title") }

      it "updates its year" do
        controller.send(:update_events)
        event.reload.date.year.should > Time.now.year
      end
    end
  end

end
