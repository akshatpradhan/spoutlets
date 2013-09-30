# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    content "i'm sick & its annoying bc i need to work but I'm tired as hell."
    category "just feeling off"
    published "true"
    happiness_level "1"
    anxiety_level "5"
    irritation_level "3"
    factory :entry_without_emotional_state do
      happiness_level "0"
      anxiety_level "0"
      irritation_level "0"
    end
  end
end
