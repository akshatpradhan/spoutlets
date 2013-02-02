# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
# TODO: see if this code is or should be used.
  factory :user do
    name 'Test User'
    email 'example@example.com'
#   password 'changeme'
#   password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
