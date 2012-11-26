require 'spec_helper'

#NOTE: Gateway should use Vacuum gem to wrap Amazon API requests.
# This is blocked until Associate/Affiliate ID/TAG is resolved/provided.
describe GiftRecommendation::Gateway do

  before do
    persona = create(:persona, :title => "Nerd")
    @recipient = create(:recipient, :personas => [persona])
    @event = Event.new(:title => "Christmas")
    GiftRecommendation::Recommendation.any_instance.stub(:recommendation).and_return( {:key => "value"} )
  end

  describe "Making the api request" do
    subject { GiftRecommendation::Gateway.new(@recipient, @event) }

  end

  describe "Manipulating a recommendation" do
    context "when recipient has at least one associated persona" do

      subject { GiftRecommendation::Gateway.new(@recipient, @event) }

      its(:recommend) { should be_kind_of(GiftRecommendation::Recommendation) }
    end

    context "when recipient has no personas" do
      let(:recipient) { create(:recipient) }
      subject { GiftRecommendation::Gateway.new(recipient) }

      it "raises an error" do
        lambda { subject.recommend }.should raise_error(StandardError)
      end
    end
  end

  describe "Remote shopping cart" do
    pending "will get built during email building phase."
  end
end

describe GiftRecommendation::ApiRequest do
  # This will get more sophisticated but, for now, just uses one browsenode (PS3)
  # for Nerd persona
  describe "Making a (basic) Amazon request" do
    before :each do
      @persona = double("Persona")
      @persona.stub(:title) { "Nerd" }
    end

    it "returns a response in xml" do
      api = GiftRecommendation::ApiRequest.new(@persona)
      api.request.class.should == Excon::Response
    end
  end
end

describe GiftRecommendation::Recommendation do
  describe "#recommendation" do
    before do
      GiftRecommendation::ApiRequest
        .any_instance.stub(:request)
        .and_return( [{:asin => "num", :title => "title", :url => "path_to_amazon"}])

      persona = create(:persona, :title => "Nerd")
      @recipient = create(:recipient, :personas => [persona])
      @items = GiftRecommendation::ApiRequest.new(persona).request
    end
    subject { GiftRecommendation::Recommendation.new(@recipient, @event, @items) }

  end
end