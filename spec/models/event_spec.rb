# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  date       :date             not null
#  repeats    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
end
