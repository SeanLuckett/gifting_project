require 'nokogiri'

module GiftRecommendation
  class Gateway
    # nodeset = xml_obj.xpath("//am:node_name", "am" => "NAMESPACE") is how this is used
    NAMESPACE = "http://webservices.amazon.com/AWSECommerceService/2011-08-01"
    
    def initialize(recipient)
      @recipient = recipient
      @api_request = ApiRequest.new("Nerd") #hardcoded to just one person: "Nerd" for now
    end

    def recommend
      raise StandardError, "No Personas" if @recipient.personas.count == 0
      node_set = process_request
      items = extract_items(node_set)
      recommendation = Recommendation.new(@recipient, items).build

      recommendation
    end

    private
    def process_request
      xml = Nokogiri::XML(@api_request.request.body)
      xml.xpath("//amazon:TopItem", "amazon" => NAMESPACE)
    end

    def extract_items(nodes)
      items = []
      nodes.each do |node|
        item = {}
        item[:asin] = node.children[0].text #amazon product id
        item[:title] = node.children[1].text
        item[:url] = node.children[2].text
        items << item
      end
      
      items.uniq { |i| i[:asin] }
    end
  end

  # Put in own file
  class Recommendation
    attr_reader :recipient, :top_recommended, :alt_recommended

    def initialize(recipient, items)
      @recipient = recipient
      @items = items
    end

    def build
      top_recommendation
      alternative_recommendations
      self
    end

    private

    def top_recommendation
      # arbitrary
      @top_recommended = @items.first
    end

    def alternative_recommendations
      # arbitrary
      @alt_recommended = @items[-9, 5]
    end

  end

  # separate file
  class ApiRequest
    def initialize(persona)
      @persona = persona
      creds = YAML.load_file Rails.root + 'config/amazon.yml'
      @request = Vacuum.new
      @request.configure(creds)

      @scopes = %w(MostGifted MostWishedFor TopSellers).join(',')
    end

    def request
      params = {
        'Operation' => 'BrowseNodeLookup',
        'BrowseNodeId' => '14210751', #hardcoded to ps3 games for Nerd persona for now
        'ResponseGroup' => @scopes
      }

      @request.get(query: params)
    end
  end
end
