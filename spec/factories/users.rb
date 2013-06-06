FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid "100004721472441"
    name "Bob Raymond"
    email "victory_records@hotmail.com"
  end
end
