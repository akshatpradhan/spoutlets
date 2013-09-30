FactoryGirl.define do

  # user factory without associated entries
  factory :user do
    sequence(:name) {|n| "user#{n}"}
    email {|user| "#{user.name}@example.com".downcase}
    password "dontellanyone"
    password_confirmation { |user| user.password}
    # https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#associations
    # user factory with associated posts
    factory :user_with_entries do
      # entries_count is declared as an ignored attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        entries_count 3
      end
      #`create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the entry
      before(:create) do |user, evaluator|
        user.entries = create_list(:entry, evaluator.entries_count, user: user)
      end
    end
  end
end
