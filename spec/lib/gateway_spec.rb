require 'spec_helper'

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

end

describe GiftRecommendation::APIRequest do
  # This will get more sophisticated but, for now, just uses one browsenode (PS3)
  # for Nerd persona
  describe "Making a (basic) Amazon request" do
    before :each do
      @browse_node_list = double("Browse Node list").as_null_object
    end

    it "returns a list of top items" do
      api = GiftRecommendation::APIRequest.new(@browse_node_list)
      api.request_list.class.should == Array
    end
  end
end

describe GiftRecommendation::Recommendation do
  before do
    GiftRecommendation::APIRequest
    .any_instance.stub(:request)
    .and_return( [{:asin => "num", :title => "title", :url => "path_to_amazon"}])

    persona = create(:persona, :title => "Nerd")
    @recipient = create(:recipient, :personas => [persona])
    @items = GiftRecommendation::APIRequest.new(persona).request
  end

  subject { GiftRecommendation::Recommendation.new(@recipient, @event, @items) }

  it { should respond_to :recipient }
  it { should respond_to :event }
  it { should respond_to :top_recommended }
  it { should respond_to :alt_recommended }

end
