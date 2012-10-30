# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipient do
    id 1
    fb_id 42
    name "MyString McMystring"
    image "/some/path_to/MyImage"
    spend_at_least 5
    spend_at_most 25
    birthday { 21.years.ago }
    user
  end
end
