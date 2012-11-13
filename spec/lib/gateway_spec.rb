require 'spec_helper'

describe RecommendationEngine::Gateway do
  let(:recipient) { double("Recipient", :user_id => 1) }
  subject { RecommendationEngine::Gateway.new(recipient) }


  describe "building the amazon api request" do

  end

  describe "returning a recommendation" do
    pending "working on amazon request first"
  end

end