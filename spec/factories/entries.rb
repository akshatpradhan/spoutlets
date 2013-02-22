# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do

    anxiety_level "passive"

    factory :anxious_entry do
      anxiety_level "panic"
    end

    factory :happy_entry do
      anxiety_level "happy"
    end
  end

end
