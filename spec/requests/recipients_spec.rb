require 'spec_helper'

describe "Recipients" do
  before { sign_in_facebook_user }
  let(:user) { User.first }
  subject { page }

  describe "#index" do
    before do
        user.recipients.create(:name => "Phil", :address1 => "Fleet Street", :birthday => 21.years.ago.to_date,
                               :city => "Denver", :state => "CO", :zip_code => "80202")
        user.recipients.create(:name => "Janice")

      visit user_recipients_path(user)
    end

    context "when viewing user's recipients" do
      it { should have_content "Phil" }
      it { should have_content "Janice" }
    end

    context "when clicking a recipient" do
      it "displays recipient's edit page" do
        click_link "Phil"
        page.should have_content "Edit Phil"
      end
    end

    context "when clicking delete" do
      it "destroys a recipient" do
        expect { click_link('X') }.to change(Recipient, :count).by(-1)
      end
    end

    context "when clicking import from facebook" do
      before :each do
        click_link 'Import from Facebook'
      end

      it "routes to recipients/inport_friends" do
        current_path.should == import_friends_path
      end
    end

    context "when recipient is missing needed data" do
      # janice, in this case
      it { should have_content "Birthday is blank." }
      it { should have_content "Address is incomplete."}
    end
  end

  describe "#new" do
    before :each do
      @personas = [create(:persona, :title => "Nerd"),
                   create(:persona, :title => "Giant")]
      @events = user.events
      visit new_user_recipient_path(user)

      fill_in "recipient[name]", :with => "Joseph P. Tester"
      select('October', :from => 'recipient[birthday(2i)]')
      select('16', :from => 'recipient[birthday(3i)]')
      select('1980', :from => 'recipient[birthday(1i)]')
      fill_in "recipient[spend_at_least]", :with => "5"
      fill_in "recipient[spend_at_most]", :with => "25"
    end

    it "creates a new recipient" do
      expect { click_button 'Done' }.to change(Recipient, :count).by(1)
    end

    it "shows the created recipient" do
      click_button 'Done'
      page.should have_content "Joseph P. Tester"
    end

    it "notifies user of success" do
      click_button 'Done'
      page.should have_content "Recipient created."
    end

    it "validates name field" do
      fill_in "recipient[name]", :with => ""
      click_button 'Done'
      page.should have_content "Name can't be blank"
    end

    context "when associating personas" do

      it "associates a persona" do
        check("#{@personas[0].title}")
        click_button 'Done'
        user.recipients.first.personas.count.should == 1
      end

      it "associates several personas" do
        check("#{@personas[0].title}")
        check("#{@personas[1].title}")
        click_button 'Done'

        user.recipients.first.personas.count.should == 2
      end
    end

    context "when associating events" do

      it "associates an event" do
        check("#{@events[0].title}")
        click_button 'Done'
        user.recipients.first.events.count.should == 1
      end

      it "associates several events" do
        check("#{@events[0].title}")
        check("#{@events[1].title}")
        click_button 'Done'

        user.recipients.first.events.count.should == 2
      end
    end
  end

  describe "#edit" do
    before :each do
      @personas = [create(:persona, :title => "Nerd"),
                   create(:persona, :title => "Giant")]
      @events = user.events
      @recipient = user.recipients.create(:name => "Jerry Joe Jameson",
                                        :spend_at_least => 5,
                                        :spend_at_most => 25,
                                        :birthday => nil)

      visit edit_user_recipient_path(user, @recipient)
    end

    it "changes an attribute" do
      fill_in 'recipient[spend_at_least]', :with => '10'
      click_button 'Done'
      @recipient.reload.spend_at_least.should == 10
    end

    describe "missing data warnings" do
      context "when recipient is missing birthday" do
        it "displays a warning" do
          subject.should have_content "While birthday isn't required, it helps us make helpful gift recommendations."
        end
      end

      context "when recipient is missing any part of address" do
        it "displays a warning" do
          subject.should have_content "We can't send a gift to this recipient until we have a valid shipping address."
        end
      end
    end


  end
end
