module RecommendationEngine
  class Gateway
    BASE_REQUEST_URL = "http://aws.amazonaws.com/onca/xml?Service=AWSECommerceService&AWSAccessKeyId=#{AMAZON['ACCESS_KEY']}&AssociateTag=#{AMAZON['ASSOCIATE_TAG']}&" 

    def initialize(recipient)
      @recipient = recipient
    end

  end

  # Put in own file
  class Recommendation
  end
end