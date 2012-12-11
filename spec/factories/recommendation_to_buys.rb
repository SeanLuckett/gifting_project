# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommendation_to_buy do
    recipient_id ""
    event_id ""
    gift_name "MyString"
    gift_url "MyString"
    bought false
    buy_date "2012-12-10 15:36:00"
  end
end
