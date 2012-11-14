module RecommendationEngine
  class Gateway
    def initialize(recipient)
      @recipient = recipient
      @recommendation = Recommendation.new(@recipient)
    end

    def recommend
      raise NoPersonasError if @recipient.personas.count == 0
      @recommendation.recommendation
    end

    def recommend_to_json
      @recommendation.recommendation.to_json
    end
  end

  # Put in own file
  class Recommendation
    def initialize(recipient)
      @recipient = recipient
      @request = ApiRequest.new(get_personas)
    end

    def recommendation
      {
        :name => @recipient.name,
        :personas => get_personas,
        :top_recommended => top_recommended, 
        :alternative_recommended => alternative_recommended
      }
    end

    private
    def get_personas
      @recipient.personas.map(&:title)
    end

    def top_recommended
      ""
    end

    def alternative_recommended
      ["gift1", "gift2"]
    end

  end

  class ApiRequest
    def initialize(personas)
      @personas = personas
    end
  end

  class Gift
  end

  class NoPersonasError < StandardError; end
end