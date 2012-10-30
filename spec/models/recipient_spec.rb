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
#

require 'spec_helper'

describe Recipient do
  subject { FactoryGirl.create(:recipient)}

  it { should respond_to(:birthday) }
  it { should respond_to(:image) }
  it { should respond_to(:name) }
  it { should respond_to(:fb_id) }
  it { should respond_to(:user_id) }

  it { should be_valid }

  describe "when name isn't present" do
    before { subject.name = " "}
    it { should_not be_valid }
  end

  describe "validating spending amounts" do
    context "when validating spend at least" do
      before { subject.spend_at_least = "dork" }
      it { should_not be_valid }
    end

    context "when validating spend at most" do
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
end
