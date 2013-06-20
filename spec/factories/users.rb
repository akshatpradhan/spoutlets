FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid "100004721472441"
    name "Bob Raymond"
  end
end
