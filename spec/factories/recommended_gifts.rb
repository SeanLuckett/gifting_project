# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommended_gift, :class => 'RecommendedGifts' do
    recipient_id 1
    event_id 1
    gift_name "MyString"
    gift_url "MyString"
    bought false
    buy_date "2012-12-11 14:36:44"
  end
end
