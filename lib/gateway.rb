module RecommendationEngine
  class Gateway

    def initialize(recipient)
      @recipient = recipient
    end

    def build_request(request)
      ApiRequest.new(request).build_request
    end

  end

  # Put in own file
  class Recommendation
  end

  # class ApiRequest
  #   BASE_REQUEST_URL = "http://aws.amazonaws.com/onca/xml?Service=AWSECommerceService&AWSAccessKeyId=#{AMAZON['ACCESS_KEY']}&" 

  #   def initialize(request)
  #     @request = request
  #   end

  #   def build_request
  #     set_request = BASE_REQUEST_URL + set_parameter_values
  #   end

  #   private
  #   def set_parameter_values
  #     prepared_request = []
  #     @request.each do |param, value|
  #       par = to_amazon_parameter(param)
  #       val = encode_spaces(value)
  #       prepared_request << par + "=" + val
  #     end
  #     @request = prepared_request.join('&')
  #   end

  #   def to_amazon_parameter(parameter)
  #     parts = parameter.to_s.split("_")
  #     parts.each do |part|
  #       part.capitalize!
  #       unless part.to_i == 0
  #         part.insert(0, ".")
  #       end
  #     end
  #     parts.join
  #   end 

  #   def encode_spaces(request)
  #     request.to_s.gsub(/ /, "%20")
  #   end
  # end
end