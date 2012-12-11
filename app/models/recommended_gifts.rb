class RecommendedGifts < ActiveRecord::Base
  attr_accessible :bought, :buy_date, :event_id, :gift_name, :gift_url, :recipient_id
end
