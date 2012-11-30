require 'spec_helper'

describe TodoItem do
  describe "events that include recipients with missing data" do
    before do
      # missing address
      @rec1 = create(:recipient, :name => "Sally")

      @rec2 = create(:recipient, :name => "Harry",
                     :address1 => "Street",
                     :city => "Springfield",
                     :state => "WA",
                     :zip_code => "80202")

      @event1 = create(:event, :recipients => [@rec1, @rec2])
    end

    subject { TodoItem.new(@event1, "Explanation") }

    it "has an explanation" do
      subject.explanation.should == "Explanation"
    end
    
    it "includes the event" do
      subject.task.should == @event1
    end

    it "should have recipients" do
      subject.task.recipients.count.should == 2
    end
  end
end
