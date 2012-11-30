# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :id do |n|
    n
  end

  factory :recipient do
    id
    fb_id 42
    name "MyString McMystring"
    image "/some/path_to/MyImage"
    spend_at_least 5
    spend_at_most 25
    birthday { 21.years.ago }
    state "CO"
    user
  end

  factory :recipient_with_persona do
    id 1
    fb_id 42
    name "MyString McMystring"
    spend_at_least 5
    spend_at_most 25
    personas {[FactoryGirl.create(:persona)]}
  end
end
