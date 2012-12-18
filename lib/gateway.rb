# I chose the following design for the recommendation engine in order
# to make it lightweight and changeable.  For instance, it would certainly
# make sense to have the APIRequest object put the price and image into the gift items
# before returning the list to the Recommendation object.  However, that's a lot of
# Amazon API requests and the MVP is set just to work on 6 items (1 top recommendation;
# 5 alternatives).  So, I do some list processing and product weighting before grabbing
# additional information.
# ######################################################################################
require 'nokogiri'

module GiftRecommendation
  class Gateway
    
    def initialize(recipient, event)
      @recipient = recipient
      @event = event
    end

    def recommend
      raise StandardError, "No Personas" if @recipient.personas.count == 0

      # Hardcoded to just one persona and browse node: "Nerd" for now
      # Eventually, the gateway would do a browse_node lookup for all the nodes
      # related to all the personas assigned to Recipient.
      browse_nodes = ['14210751']

      recommendation = Recommendation.new(@recipient, @event, browse_nodes).build

      recommendation
    end
  end

  # Put in own file
  class Recommendation
    attr_reader :recipient, :top_recommended, :alt_recommended, :event

    def initialize(recipient, event, browse_nodes)
      @recipient = recipient
      @event = event
      @amazon = APIRequest.new(browse_nodes) #hardcoded to just one node: PS3 video games for now
    end

    def build
      recommended_items = @amazon.request_list
      @items = sorted_by(:weight, recommended_items)

      top_recommendation
      alternative_recommendations
      self
    end

    private

    def top_recommendation
      # Top item sorted to back of array
      @top_recommended = add_price_and_image_to(@items.first)
    end

    def alternative_recommendations
      # arbitrary
      @alt_recommended = @items[1, 5]

      @alt_recommended.each do |item|
        add_price_and_image_to(item)
      end
    end

    def sorted_by(attr, items)
      # puts most heavily weighted at beginning
      items.sort! { |item1, item2| item2[attr] <=> item1[attr] }
    end

    def add_price_and_image_to(item)
      @amazon.item_price_and_image(item)
    end

  end

  # separate file
  class APIRequest
    AMAZON_NAMESPACE = "http://webservices.amazon.com/AWSECommerceService/2011-08-01"

    def initialize(browse_nodes)
      @browse_nodes = browse_nodes
      creds = {
        :key => ENV['amazon_key'],
        :secret => ENV['amazon_secret'],
        :tag => ENV['amazon_tag']
      }
      @request = Vacuum.new
      @request.configure(creds)
    end

    def request_list
      scopes = %w(MostGifted MostWishedFor TopSellers).join(',')
      params = {
        'Operation' => 'BrowseNodeLookup',

        # hardcoded to ps3 games for Nerd persona for now
        # eventually, there will be more than one, but Amazon doesn't seem to have a batch
        # browse node lookup.
        'BrowseNodeId' => @browse_nodes.first,
        'ResponseGroup' => scopes
      }

      XMLHandler.new(@request.get(query: params)).get_recommendation_list
    end

    def item_price_and_image(item_to_lookup)
      scopes = %w(
        Offers Images
      ).join(',')

      params = {
        'Operation'     => 'ItemLookup',
        'Idtype'        => 'ASIN',
        'ResponseGroup' => scopes,
        'ItemId'        => item_to_lookup[:asin]
      }

      xml_handler = XMLHandler.new(@request.get(query: params))

      item_to_lookup[:price] = xml_handler.get_price
      item_to_lookup[:img_url] = xml_handler.get_image_url

      item_to_lookup
    end
  end

  class XMLHandler
    AMAZON_NAMESPACE = "http://webservices.amazon.com/AWSECommerceService/2011-08-01"

    def initialize(raw_request)
      @xml = Nokogiri::XML(raw_request.body)
    end

    def get_price
      # formatted price ie "10.25"
      # xpath format specific to Amazon response object
      @xml.xpath("//amazon:Price", "amazon" => AMAZON_NAMESPACE).children[2].text
    end

    def get_image_url
      # xpath format specific to Amazon response object
      @xml.xpath("//amazon:MediumImage", "amazon" => AMAZON_NAMESPACE).children[0].text
    end

    def get_recommendation_list
      top_items = @xml.xpath("//amazon:TopItem", "amazon" => AMAZON_NAMESPACE)

      asins = []
      items = []
      top_items.each do |node|
        item = {}
        item[:asin] = node.children[0].text #amazon product id
        # if item already in items, add to its importance (weight) rather than duplicate
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
end
