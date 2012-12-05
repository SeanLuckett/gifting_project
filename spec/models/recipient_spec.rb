# == Schema Information
#
# Table name: recipients
#
#  id             :integer          not null, primary key
#  fb_id          :string(255)
#  name           :string(255)
#  image          :string(255)
#  birthday       :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  spend_at_least :integer
#  spend_at_most  :integer
#  address1       :string(255)
#  address2       :string(255)
#  state          :string(2)
#  city           :string(255)
#  zip_code       :string(255)
#

require 'spec_helper'

describe Recipient do
  subject { FactoryGirl.create(:recipient)}

  it { should respond_to(:birthday) }
  it { should respond_to(:image) }
  it { should respond_to(:name) }
  it { should respond_to(:fb_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:age) }

  it { should be_valid }

  describe "when name isn't present" do
    before { subject.name = " "}
    it { should_not be_valid }
  end

  describe "validating spending amounts" do
    context "when validating spend at least, a non-numberical value" do
      before { subject.spend_at_least = "dork" }
      it { should_not be_valid }
    end

    context "when validating spend at most, a non-numberical value" do
      before { subject.spend_at_most = "dork" }
      it { should_not be_valid }
    end

    context "when spend_at_least is greater than spend_at_most" do
      before { subject.spend_at_least = 20; subject.spend_at_most = 10}
      it { should_not be_valid }
    end
  end

  describe "Can extract first name" do
    its(:first_name) { should == "MyString" }
  end

  describe "#age" do
    context "When birthday is missing" do
      it "has no age" do
        recipient = create(:recipient, :birthday => nil)
        recipient.age.blank?.should be_true
      end
    end

    context "When birthday is next day" do
      before { subject.birthday = Date.tomorrow.change(:year => 21.years.ago.year); subject.save! }
      it { subject.age.should == 20 }
    end

    context "When birthday was yesterday" do
      before { subject.birthday = Date.yesterday.change(:year => 21.years.ago.year); subject.save! }
      it { subject.age.should == 21 }
    end

    context "When birthday is today" do
      before { subject.birthday = Date.today.change(:year => 21.years.ago.year); subject.save! }
      it { subject.age.should == 21 }
    end
  end

  describe "Missing data warnings" do
    context "when birthday is missing, age can't be determined" do
      it { expect{ subject.birthday = "" }.to change{subject.warnings.count}.by(1) }
      it { expect{ subject.warnings.include? "Birthday is blank." }.to be_true }
    end

    context "when address is incomplete" do
      before do
        subject.address1 = "Street"
        subject.address2 = ""
        subject.city = "Denver"
        subject.state = "CO"
        subject.zip_code = "80907"
      end

      it { expect{ subject.address1 = "" }.to change{subject.warnings.count}.by(1) }
      it { expect{ subject.city = "" }.to change{subject.warnings.count}.by(1) }
      it { expect{ subject.zip_code = "" }.to change{subject.warnings.count}.by(1) }
      it { expect{ subject.state = "" }.to change{subject.warnings.count}.by(1) }

      it "Stores warning message" do
        subject.city = ""
        subject.warnings.include?("Address is incomplete.").should be_true
      end
    end
  end

  describe ".with_missing_data" do
    before do
      # missing address
      @rec1 = create(:recipient, :name => "Sally")

      # missing birthday
      @rec2 = create(:recipient, :name => "Harry", :birthday => nil,
                                 :address1 => "Street",
                                 :city => "Springfield",
                                 :state => "WA",
                                 :zip_code => "80202")
    end

    let(:recipients_with_missing_data) { Recipient.with_missing_data }

    specify { recipients_with_missing_data.count.should eq(2) }
  end

end
