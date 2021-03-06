require 'spec_helper'

describe Persona do
  subject { FactoryGirl.create(:persona) }

  it {should respond_to(:title)}
  it {should respond_to(:description)}

  it { should be_valid }

  describe "when title isn't present" do
    before { subject.title = " " }
    it { should_not be_valid }
  end
end
