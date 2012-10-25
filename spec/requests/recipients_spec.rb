require 'spec_helper'

describe "Recipients" do
  before { sign_in_facebook_user }
  let(:user) { User.first }
  subject { page }

  describe "#index" do
    before do
      ["Phil", "Janice"].each do |name|
        user.recipients.create(:name => name)
      end

      visit user_recipients_path(user)
    end

    context "when viewing user's recipients" do
      it { should have_content "Phil" }
      it { should have_content "Janice" }
    end

    context "when clicking delete" do
      it "destroys a recipient" do
        expect { click_link('X') }.to change(Recipient, :count).by(-1)
      end
    end
  end

  describe "#new" do
    before :each do
      @personas = [FactoryGirl.create(:persona, :title => "Nerd"),
                   FactoryGirl.create(:persona, :title => "Giant")]
      @events = [FactoryGirl.create(:event, :title => "Xmas"),
                 FactoryGirl.create(:event, :title => "Valentine's")]
      visit user_recipients_path(user)

      click_link "New"
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
      page.should have_content "Recipient successfully created."
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
end