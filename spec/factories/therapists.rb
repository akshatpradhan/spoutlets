# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :therapist do
    provider "linkedin"
    uid "100004721472441"
    name "Sigmund Freud"
    email "s.freud@apa.com"
    association :invited_by, factory: :user
    invitation_accepted_at Time.now.utc
  end
end
