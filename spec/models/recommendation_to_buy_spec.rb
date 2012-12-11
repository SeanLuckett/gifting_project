require 'spec_helper'

describe RecommendationToBuy do
  subject { RecommendationToBuy.new() }

  it { should respond_to(:bought) }
  it { should respond_to(:buy_date) }
  it { should respond_to(:event_id) }
  it { should respond_to(:gift_name) }
  it { should respond_to(:gift_url) }
  it { should respond_to(:recipient_id) }
end
