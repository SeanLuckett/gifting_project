require 'spec_helper'

describe Event do
  subject { FactoryGirl.create(:event) }

  it { should respond_to(:title) }
  it { should respond_to(:date) }
  it { should respond_to(:repeats) }

  it { should be_valid }

  describe "when title isn't present" do
    before { subject.title = " " }
    it { should_not be_valid }
  end

  describe "when date isn't present" do
    before { subject.date = " " }
    it { should_not be_valid }
  end

  describe ".priority" do
    context "when duration is 2 weeks" do
      before do
        @user = create(:user)
        @event1 = create(:event, :user_id => @user.id, :title => "Event1", :date => 2.weeks.since.to_date)
        @event2 = create(:event, :user_id => @user.id, :title => "Event2", :date => 1.weeks.since.to_date)
        @event3 = create(:event, :user_id => @user.id, :title => "Event3", :date => (2.weeks.since + 1.day).to_date)

        @num_weeks = 2
      end

      it "returns events withing 2 weeks" do
        Event.priority(@num_weeks, @user.id).include?(@event1).should be_true
        Event.priority(@num_weeks, @user.id).include?(@event2).should be_true
      end

      it "doesn't return events outside 2 weeks" do
        Event.priority(@num_weeks, @user.id).include?(@event3).should be_false
      end

      it "sorts the list by date soonest to latest" do
        Event.priority(@num_weeks, @user.id).first.should == @event2
      end
    end
  end
end
