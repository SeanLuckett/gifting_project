require 'spec_helper'

describe "Events" do
  before { sign_in_facebook_user }
  let(:user) { User.first }
  subject { page }

  describe "#index" do
    before do
      visit user_events_path(user)
    end

    # When user is created, default events are created
    context "when viewing user's default events" do
      it { should have_content "Christmas" }
      it { should have_content "Valentine" }
    end

    context "when clicking an event" do
      it "displays the event's edit page" do
        pending "Implement during event edit feature"
      end
    end

    context "when clicking delete" do
      it "destroys an event" do
        expect { click_link('X') }.to change(Event, :count).by(-1)
        page.should have_content "You removed"
      end
    end
  end

  describe "#new" do
    before :each do
      @recipient = create(:recipient, :user => user)
      visit new_user_event_path(user)

      fill_in "event[title]", :with => "#{@recipient.first_name}'s Birthday"
      select('June', :from => 'event[date(2i)]')
      select('16', :from => 'event[date(3i)]')
      select(Time.now.year.next.to_s, :from => 'event[date(1i)]')
      choose('repeats_yes')
    end

    it "creates a new event" do
      expect { click_button 'Done' }.to change(Event, :count).by(1)
    end

    it "shows the created event" do
      click_button 'Done'
      page.should have_content "#{@recipient.first_name}'s Birthday"
    end

    it "notifies user of success" do
      click_button 'Done'
      page.should have_content "Event created."
    end

    context "when validating name field" do
      before do
        fill_in "event[title]", :with => ""
        click_button 'Done'
      end

      it { should have_content "Title can't be blank" }
    end

    context "when associating recipients" do
      before do
        check("#{@recipient.name}")
        click_button 'Done'
      end
      it "associates a recipient" do
        new_event = Event.find_by_title("#{@recipient.first_name}'s Birthday")
        new_event.recipients.count.should == 1
      end
    end

  end
end