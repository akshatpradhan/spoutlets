# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :entry do

    content "This is default content"
    category "happiness"
    
    factory :published_entry do 
      published true
    end

    factory :invalid_entry do
      content nil
    end

  end

end
