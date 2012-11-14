require 'spec_helper'

#NOTE: Gateway should use Vacuum gem to wrap Amazon API requests.
# This is blocked until Associate/Affiliate ID/TAG is resolved/provided.
describe RecommendationEngine::Gateway do
  describe "Manipulating a recommendation" do
    context "when recipient has at least one associated persona" do
      before do
        persona = create(:persona, :title => "Nerd")
        @recipient = create(:recipient, :personas => [persona])
        RecommendationEngine::Recommendation.any_instance.stub(:recommendation).and_return( {:key => "value"} )
      end

      subject { RecommendationEngine::Gateway.new(@recipient) }

      its(:recommend) { should be_kind_of(Hash) }

      it "returns recommendation in json" do
        subject.recommend_to_json.should == "{\"key\":\"value\"}"
      end
    end

    context "when recipient has no personas" do
      let(:recipient) { create(:recipient) }
      subject { RecommendationEngine::Gateway.new(recipient) }

      it "raises an error" do
        lambda { subject.recommend }.should raise_error(RecommendationEngine::NoPersonasError)
      end
    end
  end

  describe "Remote shopping cart" do
    pending "Must have amazon api keys to start working with this"
  end
end

describe RecommendationEngine::Recommendation do
  describe "#recommendation" do
    before do
      RecommendationEngine::ApiRequest
        .any_instance.stub(:results)
        .and_return( {:key => "value"})

      persona = create(:persona, :title => "Nerd")
      @recipient = create(:recipient, :personas => [persona])
    end
    subject { RecommendationEngine::Recommendation.new(@recipient) }

    its(:recommendation) { should be_kind_of(Hash) }

    describe "the returned hash includes" do
      let(:recommendation) { subject.recommendation }

      it "recipient name" do
        recommendation.has_value?(@recipient.name).should be_true
      end

      it "titles of associated personas" do
        recommendation[:personas].should include @recipient.personas.first.title
      end

      it "the top recommended item" do
        recommendation.include?(:top_recommended).should be_true
      end

      it "alternative recommendations" do
        recommendation.include?(:alternative_recommended).should be_true
      end
    end
  end
end