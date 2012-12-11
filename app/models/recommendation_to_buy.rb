class RecommendationToBuy < ActiveRecord::Base
  attr_accessible :bought, :buy_date, :gift_name, :gift_url
end
