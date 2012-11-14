require 'spec_helper'

#NOTE: Gateway should use Vacuum gem to wrap Amazon API requests.
# This is blocked until Associate/Affiliate ID/TAG is resolved/provided.
describe RecommendationEngine::Gateway do
  before do
    persona = create(:persona, :title => "Nerd")
    @recipient = create(:recipient, :personas => [persona])
  end
  subject { RecommendationEngine::Gateway.new(@recipient) }

  describe "Getting the recommendation" do
  end

  describe "building the amazon api request" do

    # will eventually move to its own file
    # describe "RecommendationEngine::ApiRequest" do
    #   before { stub_const("RecommendationEngine::ApiRequest::BASE_REQUEST_URL", "") }

    #   context "when given single parameter name and value" do
    #     let(:request) { {:parameter_name => "this and that"} }    

    #     it "url-encodes spaces with '%20'" do
    #       subject.build_request(request).should =~ /this%20and%20that/
    #     end

    #     it "creates api parameter names from symbols" do
    #       subject.build_request(request).should =~ /ParameterName/
    #     end

    #     it "builds name/value pairs from hash" do
    #       expected_request = "ParameterName=this%20and%20that"
    #       subject.build_request(request).should == expected_request
    #     end

    #     context "when value is a number" do
    #       let(:request) { { :param => 2 } }

    #       it "builds valid request" do
    #         expected_request = "Param=2"
    #         subject.build_request(request).should == expected_request
    #       end
    #     end
    #   end

    #   context "when given more than one parameter name and value" do
    #     let(:request) { { :param_name_this => "this", :param_name_that => "that"} }

    #     it "returns a proper api string" do
    #       expected_request = "ParamNameThis=this&ParamNameThat=that"
    #       subject.build_request(request).should == expected_request
    #     end
    #   end

    #   context "when given compound parameters" do
    #     let(:request) { { :item_1 => "excellent" } }

    #     it "transforms params into copound params" do
    #       expected_request = "Item.1=excellent"
    #       subject.build_request(request).should == expected_request
    #     end
    #   end
    # end

    # it "creates official, full Amazon api request" do
    #   expected_request = "http://aws.amazonaws.com/onca/xml?Service=AWSECommerceService&AWSAccessKeyId=#{AMAZON['ACCESS_KEY']}&ParamName=this"
    #   subject.build_request(:param_name => 'this').should == expected_request
    # end
  end

  describe "returning a recommendation" do
    pending "working on amazon request first"
  end

end