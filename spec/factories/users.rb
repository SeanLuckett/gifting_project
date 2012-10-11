# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    name "MyString"
    email "test@example.com"
    oauth_token "MyString"
    oauth_expires_at "2012-09-07 13:32:23"
  end
end
