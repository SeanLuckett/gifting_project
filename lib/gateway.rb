require 'nokogiri'

module GiftRecommendation
  class Gateway
    NAMESPACE = "http://webservices.amazon.com/AWSECommerceService/2011-08-01"
    
    def initialize(recipient, event)
      @recipient = recipient
      @event = event
      @api_request = ApiRequest.new("Nerd") #hardcoded to just one person: "Nerd" for now
    end

    def recommend
      raise StandardError, "No Personas" if @recipient.personas.count == 0
      node_set = process_request
      items = extract_items(node_set)
      items.sort! { |item1, item2| item1[:weight] <=> item2[:weight] }
      recommendation = Recommendation.new(@recipient, @event, items).build

      recommendation
    end

    private
    def process_request
      xml = Nokogiri::XML(@api_request.request.body)
      xml.xpath("//amazon:TopItem", "amazon" => NAMESPACE)
    end

    def extract_items(nodes)
      asins = []
      items = []
      nodes.each do |node|
        item = {}
        item[:asin] = node.children[0].text #amazon product id
        if asins.include? item[:asin]
          index = items.rindex {|i| i[:asin] == item[:asin]}
          item = items.delete_at(index)
          item[:weight] += 1
        else
          item[:title] = node.children[1].text
          item[:url] = node.children[2].text
          item[:weight] = 1
          asins << item[:asin]
        end
        items << item
      end

      items
    end
  end

  # Put in own file
  class Recommendation
    attr_reader :recipient, :top_recommended, :alt_recommended, :event

    def initialize(recipient, event, items)
      @recipient = recipient
      @event = event
      @items = items
    end

    def build
      top_recommendation
      alternative_recommendations
      self
    end

    private

    def top_recommendation
      # Top item sorted to back of array
      @top_recommended = @items.last
    end

    def alternative_recommendations
      # arbitrary
      @alt_recommended = @items[-6, 5].sort! { |item1, item2| item2[:weight] <=> item1[:weight] }
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
