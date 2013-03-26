FactoryGirl.define do

  factory :user do

    factory :logged_in_user do
      provider "facebook"
      uid "1111112345678902"
      name "Darwin"
      email "darwin@ironcave.com"
    end

  end

end
