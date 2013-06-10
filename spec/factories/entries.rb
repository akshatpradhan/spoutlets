# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    content "i'm sick & its annoying bc i need to work but I'm tired as hell."
    category "just feeling off"
    published "true"
    anxiety_level "5"
  end
end
